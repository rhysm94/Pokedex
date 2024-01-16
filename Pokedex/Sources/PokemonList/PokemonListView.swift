//
//  PokemonListView.swift
//  PokemonList
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import SwiftUI
import ViewPokemon

public struct PokemonListView: View {
  public let store: StoreOf<PokemonList>

  public init(store: StoreOf<PokemonList>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack {
      WithViewStore(store, observe: { $0 }, send: { .view($0) }) { viewStore in
        List(viewStore.pokemon) { pokemon in
          Button {
            viewStore.send(.didTapPokemon(pokemon.id))
          } label: {
            PokemonListRow(pokemon: pokemon)
          }
        }
        .task {
          await viewStore.send(.initialise).finish()
        }
        .navigationDestination(
          store: store.scope(state: \.$presentedPokemon, action: \.viewPokemon),
          destination: ViewPokemonView.init
        )
      }
      .buttonStyle(.plain)
      .navigationTitle("Pokémon")
    }
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
    PokemonListEntry(id: 1, name: "Bulbasaur", imageURL: nil),
    PokemonListEntry(id: 2, name: "Ivysaur", imageURL: nil),
    PokemonListEntry(id: 3, name: "Venusaur", imageURL: nil),
    PokemonListEntry(id: 4, name: "Charmander", imageURL: nil),
    PokemonListEntry(id: 5, name: "Charmeleon", imageURL: nil),
    PokemonListEntry(id: 6, name: "Charizard", imageURL: nil),
    PokemonListEntry(id: 7, name: "Squirtle", imageURL: nil),
    PokemonListEntry(id: 8, name: "Wartortle", imageURL: nil),
    PokemonListEntry(id: 9, name: "Blastoise", imageURL: nil)
  ]
}
