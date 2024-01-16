//
//  Ability.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 16/01/2024.
//

public struct Ability: Hashable {
  public let id: Int
  public let name: String
  public let isHidden: Bool

  public init(id: Int, name: String, isHidden: Bool) {
    self.id = id
    self.name = name
    self.isHidden = isHidden
  }
}
