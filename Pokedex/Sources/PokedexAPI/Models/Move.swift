//
//  Move.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 16/01/2024.
//

import Tagged

public struct Move: Hashable {
  public typealias ID = Tagged<Self, Int>

  public let id: ID
  public let name: String
  public let type: PokemonType

  public init(id: Int, name: String, type: PokemonType) {
    self.id = .init(id)
    self.name = name
    self.type = type
  }
}
