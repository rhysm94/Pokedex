//
//  PokedexAPI.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 15/01/2024.
//

import Dependencies
import DependenciesMacros

@DependencyClient
public struct APIClient {
  public var getAllPokemon: () async throws -> [Pokemon]
  public var getAllAbilities: () async throws -> [Ability]
}

extension APIClient: TestDependencyKey {
  public static let testValue = Self()
}

public extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
