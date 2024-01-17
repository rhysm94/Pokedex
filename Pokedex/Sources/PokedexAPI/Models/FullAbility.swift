//
//  FullAbility.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 16/01/2024.
//

import Tagged

public struct FullAbility: Identifiable, Hashable {
  public typealias ID = Tagged<Self, Int>
  public let id: ID
  public let name: String
  public let flavourText: String
  public let pokemonWithAbility: [Pokemon]

  public init(id: Int, name: String, flavourText: String, pokemonWithAbility: [Pokemon]) {
    self.id = .init(id)
    self.name = name
    self.flavourText = flavourText
    self.pokemonWithAbility = pokemonWithAbility
  }
}
