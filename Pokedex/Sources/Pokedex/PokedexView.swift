//
//  PokedexView.swift
//  Pokedex
//
//  Created by Rhys Morgan on 12/01/2024.
//

import AbilityList
import ComposableArchitecture
import PokemonList
import SwiftUI

public struct PokedexView: View {
  let store: StoreOf<Pokedex>

  public init(store: StoreOf<Pokedex>) {
    self.store = store
  }

  private typealias Tab = Pokedex.State.Tab

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      TabView(selection: viewStore.$currentTab) {
        PokemonListView(
          store: store.scope(state: \.pokemonList, action: \.pokemonList)
        )
        .tag(Tab.pokemon)
        .tabItem {
          Text("Pokédex")
        }

        AbilityListView(
          store: store.scope(state: \.abilityList, action: \.abilityList)
        )
        .tag(Tab.abilities)
        .tabItem {
          Text("Abilities")
        }
      }
    }
  }
}
