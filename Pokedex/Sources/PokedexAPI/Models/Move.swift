//
//  Move.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 16/01/2024.
//

public struct Move: Hashable {
  public let id: Int
  public let name: String
  public let type: PokemonType

  public init(id: Int, name: String, type: PokemonType) {
    self.id = id
    self.name = name
    self.type = type
  }
}
