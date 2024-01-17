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
          if fullData.evolutionChain.species.count > 1 {
            Section("Evolutions") {
              EvolutionChainView(chain: fullData.evolutionChain) { pokemonID in
                viewStore.send(.didTapPokemon(pokemonID))
              }
            }
          }

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
          HStack {
            Spacer()
            ProgressView()
              .progressViewStyle(.circular)
            Spacer()
          }
        }
      }
      .navigationTitle(viewStore.name)
      .task {
        await viewStore.send(.initialise).finish()
      }
    }
    .navigationDestination(
      store: store.scope(state: \.$nested, action: \.viewPokemon),
      destination: ViewPokemonView.init
    )
  }
}

struct ViewState: Equatable {
  var pokedexNumber: String
  var name: String
  var imageURL: URL?

  var fullData: FullData?

  struct FullData: Equatable {
    var evolutionChain: FullPokemon.EvolutionChain
    var abilities: [Ability]
    var moves: [Move]
  }

  private static func pokedexNumber(_ number: Int) -> String {
    "#" + String(format: "%03d", number)
  }

  init(state: ViewPokemon.State) {
    switch state.loadingState {
    case .loading(let pokemon):
      self.pokedexNumber = Self.pokedexNumber(pokemon.id.rawValue)
      self.name = pokemon.name
      self.imageURL = pokemon.thumbnailURL
    case .loaded(let fullPokemon):
      self.pokedexNumber = Self.pokedexNumber(fullPokemon.id.rawValue)
      self.name = fullPokemon.name
      self.imageURL = fullPokemon.imageURL

      self.fullData = FullData(
        evolutionChain: fullPokemon.evolutionChain,
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
        initialState: ViewPokemon.State(
          loadingState: .loading(
            Pokemon(
              id: 1,
              name: "Bulbasaur",
              thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/bulbasaur.png")
            )
          )
        )
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
                Pokemon(
                  id: 1,
                  name: "Bulbasaur",
                  thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/bulbasaur.png")
                ),
                Pokemon(
                  id: 2,
                  name: "Ivysaur",
                  thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/ivysaur.png")
                ),
                Pokemon(
                  id: 3,
                  name: "Venusaur",
                  thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/venusaur.png")
                )
              ]
            ),
            typeOne: .grass,
            typeTwo: .poison,
            abilities: [],
            moves: [
              Move(id: 1, name: "Tackle", type: .normal)
            ],
            imageURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/bulbasaur.png")
          )
        }
      }
    )
  }
}
