//
//  Ability.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 16/01/2024.
//

public struct Ability: Hashable {
  public let id: Int
  public let name: String

  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
