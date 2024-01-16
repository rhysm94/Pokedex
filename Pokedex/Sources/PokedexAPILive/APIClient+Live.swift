//
//  APIClient+Live.swift
//  PokedexAPILive
//
//  Created by Rhys Morgan on 15/01/2024.
//

import Apollo
import Dependencies
import Foundation
import PokedexAPI

extension APIClient: DependencyKey {
  public static var liveValue: Self {
    let apolloClient = ApolloClient(url: URL(string: "https://beta.pokeapi.co/graphql/v1beta")!)

    return Self(
      getAllPokemon: {
        let getAllPokemon = try await apolloClient.fetch(
          query: GetAllPokemonQuery(),
          cachePolicy: .returnCacheDataElseFetch
        )

        return getAllPokemon.pokemonSpecies.compactMap { species -> Pokemon? in
          guard let name = species.pokemon_v2_pokemonspeciesnames.first?.name else {
            return nil
          }

          return Pokemon(id: species.id, name: name, thumbnailURL: spriteURL(for: species.name))
        }
      },
      getPokemon: { pokemonID in
        let getPokemon = try await apolloClient.fetch(
          query: GetPokemonQuery(pokemonID: pokemonID),
          cachePolicy: .returnCacheDataElseFetch
        )

        guard let pokemon = getPokemon.pokemon else {
          throw ApolloError.missingData
        }

        guard let name = pokemon.pokemonName.first?.name else {
          throw ApolloError.missingData
        }

        guard let pokemonData = pokemon.pokemonData.first else {
          throw ApolloError.missingData
        }

        let types = try extractTypes(from: pokemonData.types)

        let abilities = try pokemonData.abilities.compactMap { ability in
          guard let name = ability.name?.name.first?.name else { throw ApolloError.missingData }
          return Ability(id: ability.id, name: name, isHidden: ability.is_hidden)
        }

        let moves = try pokemonData.moves.compactMap { move in
          guard
            let name = move.move?.name.first?.name,
            let typeName = move.move?.type?.pokemon_v2_typenames.first?.name,
            let type = PokemonType(rawValue: typeName)
          else { throw ApolloError.missingData }

          return Move(id: move.id, name: name, type: type)
        }

        return try FullPokemon(
          id: pokemonID,
          name: name,
          evolvesFrom: getPokemon.pokemon?.evolves_from_species_id,
          evolutionChain: FullPokemon.EvolutionChain(data: getPokemon),
          typeOne: types.typeOne,
          typeTwo: types.typeTwo,
          abilities: abilities,
          moves: moves,
          imageURL: spriteURL(for: pokemon.name)
        )
      },
      getAllAbilities: {
        let getAllAbilities = try await apolloClient.fetch(
          query: GetAllAbilitiesQuery(),
          cachePolicy: .returnCacheDataElseFetch
        )

        return getAllAbilities.pokemon_v2_ability.compactMap { ability in
          guard let name = ability.pokemon_v2_abilitynames.first?.name else {
            return nil
          }

          return Ability(id: ability.id, name: name, isHidden: false)
        }
      }
    )
  }
}

private func spriteURL(for pokemonSpecies: String) -> URL? {
  URL(string: "https://img.pokemondb.net/sprites/home/normal/\(pokemonSpecies).png")
}

private extension FullPokemon.EvolutionChain {
  init(data: GetPokemonQuery.Data) throws {
    guard let chain = data.pokemon?.evolutionChain else {
      throw ApolloError.missingData
    }

    let chainSpecies: [Pokemon] = try chain.species.reduce(into: []) { partialResult, species in
      guard let name = species.speciesNames.first?.name else { throw ApolloError.missingData }
      partialResult.append(
        Pokemon(id: species.id, name: name, thumbnailURL: spriteURL(for: species.name))
      )
    }.sorted(by: { $0.id < $1.id })

    self.init(id: chain.id, species: chainSpecies)
  }
}

private func extractTypes(from types: [GetPokemonQuery.Data.Pokemon.PokemonDatum.Type_SelectionSet]) throws -> (typeOne: PokemonType, typeTwo: PokemonType?) {
  let types = types
    .compactMap { $0.type?.name.first?.name }
    .compactMap(PokemonType.init(rawValue:))

  guard let first = types.first else { throw ApolloError.missingData }
  return (first, types.dropFirst().first)
}

enum ApolloError: Error {
  case unexpectedError
  case missingData
}
