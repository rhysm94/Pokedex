//
//  ViewPokemonTests.swift
//  ViewPokemonTests
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import ViewPokemon
import XCTest

@MainActor
final class ViewPokemonTests: XCTestCase {
  func testInitialise() async {
    let store = TestStore(
      initialState: ViewPokemon.State(
        loadingState: .loading(
          Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil)
        )
      )
    ) {
      ViewPokemon()
    } withDependencies: {
      $0.apiClient.getPokemon = { _ in .bulbasaur }
    }

    await store.send(.view(.initialise))

    await store.receive(\.receiveFullPokemon.success, .bulbasaur) {
      $0.loadingState = .loaded(.bulbasaur)
    }
  }

  func testTapOnPokemon() async {
    let store = TestStore(initialState: ViewPokemon.State(loadingState: .loaded(.bulbasaur))) {
      ViewPokemon()
    }

    await store.send(.view(.didTapPokemon(1))) // Same ID as Bulbasaur

    // No state mutations, no missed actions – nothing happens

    await store.send(.view(.didTapPokemon(2))) { // Ivysaur
      $0.nested = .init(
        loadingState: .loading(
          Pokemon(
            id: 2,
            name: "Ivysaur",
            thumbnailURL: nil
          )
        )
      )
    }

    store.dependencies.apiClient.getPokemon = { _ in .ivysaur }

    await store.send(.viewPokemon(.presented(.view(.initialise))))

    await store.receive(\.viewPokemon.presented.receiveFullPokemon.success, .ivysaur) { state in
      state.nested?.loadingState = .loaded(.ivysaur)
    }
  }
}

private extension FullPokemon {
  static let bulbasaur = FullPokemon(
    id: 1,
    name: "Bulbasaur",
    evolvesFrom: nil,
    evolutionChain: .bulbasaurFamily,
    typeOne: .grass,
    typeTwo: .poison,
    abilities: [
      Ability(id: 1, name: "Overgrow", isHidden: false)
    ],
    moves: [
      Move(id: 1, name: "Tackle", type: .normal)
    ],
    imageURL: nil
  )

  static let ivysaur = FullPokemon(
    id: 2,
    name: "Ivysaur",
    evolvesFrom: 1,
    evolutionChain: .bulbasaurFamily,
    typeOne: .grass,
    typeTwo: .poison,
    abilities: [
      Ability(id: 1, name: "Overgrow", isHidden: false)
    ],
    moves: [
      Move(id: 1, name: "Tackle", type: .normal)
    ],
    imageURL: nil
  )
}

private extension FullPokemon.EvolutionChain {
  static let bulbasaurFamily = Self(
    id: 1,
    species: [
      Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil),
      Pokemon(id: 2, name: "Ivysaur", thumbnailURL: nil),
      Pokemon(id: 3, name: "Venusaur", thumbnailURL: nil)
    ]
  )
}
