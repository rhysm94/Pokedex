//
//  Pokemon.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 15/01/2024.
//

import Foundation

public struct Pokemon: Hashable {
  public let id: Int
  public let name: String

  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
