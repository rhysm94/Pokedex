//
//  ViewAbilityView.swift
//  ViewAbility
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import SwiftUI

public struct ViewAbilityView: View {
  let store: StoreOf<ViewAbility>

  public init(store: StoreOf<ViewAbility>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }, send: { .view($0) }) { viewStore in
      Form {
        if let flavourText = viewStore.flavourText {
          Section("Flavour Text") {
            Text(flavourText)
          }
        }

        if !viewStore.pokemonWithAbility.isEmpty {
          Section("Pokémon with \(viewStore.name)") {
            ForEach(viewStore.pokemonWithAbility) { pokemon in
              Text(pokemon.name)
            }
          }
        }

        if viewStore.isLoading {
          HStack {
            Spacer()

            ProgressView()
              .progressViewStyle(.circular)

            Spacer()
          }
        }
      }
      .task {
        await viewStore.send(.initialise).finish()
      }
      .navigationTitle(viewStore.name)
    }
  }
}

#Preview {
  NavigationStack {
    ViewAbilityView(
      store: Store(
        initialState: ViewAbility.State(abilityID: 1, name: "Stench", isLoading: false)
      ) {
        ViewAbility()
      } withDependencies: {
        $0.apiClient.getAbility = { _ in
          try await Task.sleep(for: .seconds(1))
          return FullAbility(
            id: 1,
            name: "Stench",
            flavourText: "By releasing stench when attacking, this Pokémon may cause the target to flinch.",
            pokemonWithAbility: [
              Pokemon(id: 44, name: "Gloom", thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/home/normal/gloom.png")),
              Pokemon(id: 88, name: "Grimer", thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/home/normal/grimer.png")),
              Pokemon(id: 89, name: "Muk", thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/home/normal/muk.png")),
            ]
          )
        }
      }
    )
  }
}
