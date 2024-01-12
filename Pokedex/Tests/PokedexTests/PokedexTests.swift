//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture
import Pokedex
import XCTest

@MainActor
final class PokedexTests: XCTestCase {
  func testInitialise() async {
    let store = TestStore(initialState: Pokedex.State()) {
      Pokedex()
    }

    await store.send(.view(.initialise))
  }
}
