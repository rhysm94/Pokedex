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

          let spriteURL = URL(string: "https://img.pokemondb.net/sprites/home/normal/\(species.name).png")

          return Pokemon(id: species.id, name: name, thumbnailURL: spriteURL)
        }
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

          return Ability(id: ability.id, name: name)
        }
      }
    )
  }
}

enum ApolloError: Error {
  case unexpectedError
}
