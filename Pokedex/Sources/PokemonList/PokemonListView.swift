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
    WithViewStore(store, observe: { $0 }, send: { .view($0) }) { viewStore in
      List(viewStore.pokemon) { pokemon in
        Button {
          viewStore.send(.didTapPokemon(pokemon.id))
        } label: {
          PokemonListRow(pokemon: pokemon)
        }
        .buttonStyle(.plain)
      }
    }
    .navigationTitle("Pokémon")
  }
}

#Preview {
  NavigationStack {
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
}

private extension PokemonListEntry {
  static let mockData: IdentifiedArrayOf<Self> = [
    PokemonListEntry(name: "Bulbasaur", imageURL: nil),
    PokemonListEntry(name: "Ivysaur", imageURL: nil),
    PokemonListEntry(name: "Venusaur", imageURL: nil),
    PokemonListEntry(name: "Charmander", imageURL: nil),
    PokemonListEntry(name: "Charmeleon", imageURL: nil),
    PokemonListEntry(name: "Charizard", imageURL: nil),
    PokemonListEntry(name: "Squirtle", imageURL: nil),
    PokemonListEntry(name: "Wartortle", imageURL: nil),
    PokemonListEntry(name: "Blastoise", imageURL: nil)
  ]
}
