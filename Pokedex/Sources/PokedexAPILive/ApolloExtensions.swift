//
//  ApolloExtensions.swift
//  PokedexAPILive
//
//  Created by Rhys Morgan on 16/01/2024.
//

import Apollo

extension ApolloClient {
  func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .default
  ) async throws -> Query.Data {
    try await withCheckedThrowingContinuation { continuation in
      fetch(query: query, cachePolicy: cachePolicy) { result in
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
