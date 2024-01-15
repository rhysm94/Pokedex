//
//  PokedexView.swift
//  Pokedex
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture
import PokemonList
import SwiftUI

public struct PokedexView: View {
  let store: StoreOf<Pokedex>

  public init(store: StoreOf<Pokedex>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      TabView(selection: viewStore.$currentTab) {
        PokemonListView(
          store: store.scope(state: \.pokemonList, action: \.pokemonList)
        )
        .tag(Pokedex.State.Tab.pokemon)
        .tabItem {
          Text("Pokédex")
        }
      }
      .task {
        await store.send(.view(.initialise)).finish()
      }
    }
  }
}
