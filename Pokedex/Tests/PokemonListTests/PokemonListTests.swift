//
//  PokemonListTests.swift
//  PokemonListTests
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import PokemonList
import XCTest

@MainActor
final class PokemonListTests: XCTestCase {
  func testInitialise() async {
    let store = TestStore(initialState: PokemonList.State(pokemon: [])) {
      PokemonList()
    } withDependencies: {
      $0.apiClient.getAllPokemon = {
        [
          Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil),
          Pokemon(id: 2, name: "Ivysaur", thumbnailURL: nil),
          Pokemon(id: 3, name: "Venusaur", thumbnailURL: nil)
        ]
      }
    }

    await store.send(.view(.initialise)) {
      $0.isLoading = true
    }

    await store.receive(\.didReceivePokemon) {
      $0.isLoading = false
      $0.pokemon = [
        PokemonListEntry(id: 1, name: "Bulbasaur"),
        PokemonListEntry(id: 2, name: "Ivysaur"),
        PokemonListEntry(id: 3, name: "Venusaur")
      ]
    }
  }

  func testNavigate() async {
    let store = TestStore(initialState: PokemonList.State(pokemon: [])) {
      PokemonList()
    } withDependencies: {
      $0.apiClient.getAllPokemon = {
        [
          Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil),
          Pokemon(id: 2, name: "Ivysaur", thumbnailURL: nil),
          Pokemon(id: 3, name: "Venusaur", thumbnailURL: nil)
        ]
      }
    }

    await store.send(.view(.initialise)) {
      $0.isLoading = true
    }

    await store.receive(\.didReceivePokemon) {
      $0.isLoading = false
      $0.pokemon = [
        PokemonListEntry(id: 1, name: "Bulbasaur"),
        PokemonListEntry(id: 2, name: "Ivysaur"),
        PokemonListEntry(id: 3, name: "Venusaur")
      ]
    }

    await store.send(.view(.didTapPokemon(1))) {
      $0.presentedPokemon = .init(
        pokemon: Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil)
      )
    }
  }
}
