//
//  Ability.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 16/01/2024.
//

import Tagged

public struct Ability: Hashable, Identifiable {
  public typealias ID = Tagged<Self, Int>
  public let id: ID
  public let name: String
  public let isHidden: Bool

  public init(id: Int, name: String, isHidden: Bool) {
    self.id = .init(id)
    self.name = name
    self.isHidden = isHidden
  }
}
