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
  public var getPokemon: (_ pokemonID: Pokemon.ID) async throws -> FullPokemon

  public var getAllAbilities: () async throws -> [Ability]
  public var getAbility: (_ abilityID: Ability.ID) async throws -> FullAbility
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
