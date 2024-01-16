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
      initialState: .loading(
        Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil)
      )
    ) {
      ViewPokemon()
    } withDependencies: {
      $0.apiClient.getPokemon = { _ in .bulbasaur }
    }

    await store.send(.view(.initialise))

    await store.receive(\.receiveFullPokemon) {
      $0 = .loaded(.bulbasaur)
    }
  }
}

private extension FullPokemon {
  static let bulbasaur = FullPokemon(
    id: 1,
    name: "Bulbasaur",
    evolvesFrom: nil,
    evolutionChain: EvolutionChain(
      id: 1,
      species: [
        Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil),
        Pokemon(id: 2, name: "Ivysaur", thumbnailURL: nil),
        Pokemon(id: 3, name: "Venusaur", thumbnailURL: nil)
      ]
    ),
    typeOne: .grass,
    typeTwo: .poison,
    abilities: [
      Ability(id: 1, name: "Overgrow")
    ],
    moves: [
      Move(id: 1, name: "Tackle", type: .normal)
    ],
    imageURL: nil
  )
}
