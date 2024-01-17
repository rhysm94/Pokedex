//
//  Pokemon.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 15/01/2024.
//

import Foundation

public struct Pokemon: Hashable, Identifiable {
  public let id: Int
  public let name: String
  public let thumbnailURL: URL?

  public init(id: Int, name: String, thumbnailURL: URL?) {
    self.id = id
    self.name = name
    self.thumbnailURL = thumbnailURL
  }
}
