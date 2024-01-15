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
        let getAllPokemon = try await apolloClient.fetch(query: GetAllPokemonQuery())

        return getAllPokemon.pokemonSpecies.compactMap { species -> Pokemon? in
          guard let name = species.pokemon_v2_pokemonspeciesnames.first?.name else {
            return nil
          }

          let spriteURL = URL(string: "https://img.pokemondb.net/sprites/home/normal/\(species.name).png")

          return Pokemon(id: species.id, name: name, thumbnailURL: spriteURL)
        }
      }
    )
  }
}

import ApolloAPI

extension ApolloClient {
  func fetch<Query: GraphQLQuery>(
    query: Query
  ) async throws -> Query.Data {
    try await withCheckedThrowingContinuation { continuation in
      fetch(query: query) { result in
        switch result {
        case let .success(data):
          guard let data = data.data else {
            continuation.resume(throwing: data.errors?.first ?? ApolloError.unexpectedError)
            return
          }

          continuation.resume(returning: data)
        case let .failure(error):
          continuation.resume(throwing: error)
          return
        }
      }
    }
  }
}

enum ApolloError: Error {
  case unexpectedError
}
