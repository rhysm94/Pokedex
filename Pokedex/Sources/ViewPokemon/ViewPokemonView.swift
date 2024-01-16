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

  public init(store: StoreOf<ViewPokemon>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: ViewState.init, send: { .view($0) }) { viewStore in
      Form {
        Section {
          AsyncImage(url: viewStore.imageURL)
            .frame(maxWidth: 320)

          Text("\(viewStore.pokedexNumber) \(viewStore.name)")
        }

        if let fullData = viewStore.fullData {
          Section("Abilities") {
            ForEach(fullData.abilities, id: \.id) { ability in
              Text(ability.name)
            }
          }

          Section("Moves") {
            ForEach(fullData.moves, id: \.id) { move in
              Text(move.name)
            }
          }
        } else {
          ProgressView()
            .progressViewStyle(.circular)
        }
      }
      .navigationTitle(viewStore.name)
      .task {
        await viewStore.send(.initialise).finish()
      }
    }
  }
}

struct ViewState: Equatable {
  var pokedexNumber: String
  var name: String
  var imageURL: URL?

  var fullData: FullData?

  struct FullData: Equatable {
    var abilities: [Ability]
    var moves: [Move]
  }

  private static func pokedexNumber(_ number: Int) -> String {
    "#" + String(format: "%03d", number)
  }

  init(state: ViewPokemon.State) {
    switch state {
    case .loading(let pokemon):
      self.pokedexNumber = Self.pokedexNumber(pokemon.id)
      self.name = pokemon.name
      self.imageURL = pokemon.thumbnailURL
    case .loaded(let fullPokemon):
      self.pokedexNumber = Self.pokedexNumber(fullPokemon.id)
      self.name = fullPokemon.name
      self.imageURL = fullPokemon.imageURL

      self.fullData = FullData(
        abilities: fullPokemon.abilities,
        moves: fullPokemon.moves
      )
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
          try await Task.sleep(for: .seconds(1))
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
