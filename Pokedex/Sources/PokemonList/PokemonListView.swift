//
//  PokemonListView.swift
//  PokemonList
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import SwiftUI

public struct PokemonListView: View {
  public let store: StoreOf<PokemonList>

  public init(store: StoreOf<PokemonList>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List(viewStore.pokemon) { pokemon in
        Text(pokemon.name)
      }
    }
  }
}

#Preview {
  PokemonListView(
    store: Store(
      initialState: PokemonList.State(
        pokemon: PokemonListEntry.mockData
      )
    ) {
      PokemonList()
    }
  )
}

private extension PokemonListEntry {
  static let mockData: IdentifiedArrayOf<Self> = [
    PokemonListEntry(name: "Bulbasaur"),
    PokemonListEntry(name: "Ivysaur"),
    PokemonListEntry(name: "Venusaur"),
    PokemonListEntry(name: "Charmander"),
    PokemonListEntry(name: "Charmeleon"),
    PokemonListEntry(name: "Charizard"),
    PokemonListEntry(name: "Squirtle"),
    PokemonListEntry(name: "Wartortle"),
    PokemonListEntry(name: "Blastoise")
  ]
}
