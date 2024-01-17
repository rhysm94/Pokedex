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
  struct TestError: Error {
    var localizedDescription: String {
      "Test Error"
    }
  }

  func testInitialise() async {
    let store = TestStore(
      initialState: ViewPokemon.State(pokemon: .bulbasaur)
    ) {
      ViewPokemon()
    } withDependencies: {
      $0.apiClient.getPokemon = { _ in .bulbasaur }
    }

    await store.send(.view(.initialise)) {
      $0.isLoading = true
    }

    await store.receive(\.receiveFullPokemon.success, .bulbasaur) {
      $0.isLoading = false
      $0.fullPokemon = .bulbasaur
    }
  }

  func testInitialise_FailureThenSuccess() async {
    let store = TestStore(
      initialState: ViewPokemon.State(pokemon: .bulbasaur)
    ) {
      ViewPokemon()
    } withDependencies: {
      $0.apiClient.getPokemon = { _ in throw TestError() }
    }

    await store.send(.view(.initialise)) {
      $0.isLoading = true
    }

    await store.receive(\.receiveFullPokemon.failure) {
      $0.isLoading = false
      $0.alert = .error(TestError())
    }

    store.dependencies.apiClient.getPokemon = { _ in .bulbasaur }

    await store.send(.alert(.presented(.retry))) {
      $0.isLoading = true
    }

    await store.receive(\.receiveFullPokemon.success, .bulbasaur) {
      $0.isLoading = false
      $0.fullPokemon = .bulbasaur
    }
  }

  func testTapOnPokemon() async {
    let store = TestStore(
      initialState: ViewPokemon.State(
        pokemon: .bulbasaur,
        fullPokemon: .bulbasaur
      )
    ) {
      ViewPokemon()
    }

    await store.send(.view(.didTapPokemon(1))) // Same ID as Bulbasaur

    // No state mutations, no missed actions – nothing happens

    await store.send(.view(.didTapPokemon(2))) { // Ivysaur
      $0.nested = ViewPokemon.State(pokemon: .ivysaur)
    }

    // Set the APIClient getPokemon output to return FullPokemon.ivysaur

    store.dependencies.apiClient.getPokemon = { _ in .ivysaur }

    await store.send(.viewPokemon(.presented(.view(.initialise)))) {
      $0.nested?.isLoading = true
    }

    await store.receive(\.viewPokemon.presented.receiveFullPokemon.success, .ivysaur) {
      $0.nested?.isLoading = false
      $0.nested?.fullPokemon = .ivysaur
    }
  }
}

private extension Pokemon {
  static let bulbasaur = Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil)
  static let ivysaur = Pokemon(id: 2, name: "Ivysaur", thumbnailURL: nil)
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
