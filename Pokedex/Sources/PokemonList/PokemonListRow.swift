//
//  PokemonListRow.swift
//  PokemonList
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import Foundation
import SwiftUI

public struct PokemonListEntry: Identifiable, Hashable {
  public var id: UUID
  public var name: String
  public var imageURL: URL?

  public init(id: UUID, name: String, imageURL: URL? = nil) {
    self.id = id
    self.name = name
    self.imageURL = imageURL
  }

  public init(name: String, imageURL: URL? = nil) {
    @Dependency(\.uuid) var uuid

    self.id = uuid()
    self.name = name
    self.imageURL = imageURL
  }
}

public struct PokemonListRow: View {
  let pokemon: PokemonListEntry

  public init(pokemon: PokemonListEntry) {
    self.pokemon = pokemon
  }

  public var body: some View {
    HStack {
      PokemonIconView(url: pokemon.imageURL)
      Text(pokemon.name)
    }
  }
}

private struct PokemonIconView: View {
  let url: URL?

  init(url: URL?) {
    self.url = url
  }

  var body: some View {
    Group {
      let circleImage = Image(systemName: "circle")
      if let url {
        AsyncImage(url: url) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        } placeholder: {
          circleImage
        }
      } else {
        circleImage
      }
    }
    .frame(width: 24, height: 24)
  }
}