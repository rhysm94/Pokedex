//
//  Pokemon.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 15/01/2024.
//

import Foundation
import Tagged

public struct Pokemon: Hashable, Identifiable {
  public typealias ID = Tagged<Self, Int>
  public let id: ID
  public let name: String
  public let thumbnailURL: URL?

  public init(id: Int, name: String, thumbnailURL: URL?) {
    self.id = .init(id)
    self.name = name
    self.thumbnailURL = thumbnailURL
  }
}
