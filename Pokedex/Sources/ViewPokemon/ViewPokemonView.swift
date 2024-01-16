//
//  ViewPokemonView.swift
//  ViewPokemon
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import SwiftUI

public struct ViewPokemonView: View {
  public let store: StoreOf<ViewPokemon>

  public var body: some View {
    WithViewStore(store, observe: { $0 }, send: { .view($0) }) { viewStore in
      Form {
        switch viewStore.state {
        case let .loading(pokemon):
          AsyncImage(url: pokemon.thumbnailURL)
            .frame(maxWidth: 320)

          Text(pokemon.name)

        case let .loaded(fullPokemon):
          Group {
            AsyncImage(url: fullPokemon.imageURL)
            Text(fullPokemon.name)

            Section("Moves") {
              ForEach(fullPokemon.moves, id: \.id) { move in
                Text(move.name)
              }
            }
          }
        }
      }
      .task {
        await viewStore.send(.initialise).finish()
      }
    }
  }
}

#Preview {
  NavigationStack {
    ViewPokemonView(
      store: Store(
        initialState: ViewPokemon.State.loading(Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil))
      ) {
        ViewPokemon()
      } withDependencies: {
        $0.apiClient.getPokemon = { _ in
          try await Task.sleep(for: .seconds(3))
          return FullPokemon(
            id: 1,
            name: "Bulbasaur",
            evolvesFrom: nil,
            evolutionChain: FullPokemon.EvolutionChain(
              id: 1,
              species: [
                Pokemon(id: 2, name: "Ivysaur", thumbnailURL: nil),
                Pokemon(id: 3, name: "Venusaur", thumbnailURL: nil)
              ]
            ),
            typeOne: .grass,
            typeTwo: .poison,
            abilities: [],
            moves: [
              Move(id: 1, name: "Tackle", type: .normal)
            ],
            imageURL: nil
          )
        }
      }
    )
  }
}
