//
//  AbilityListTests.swift
//  AbilityListTests
//
//  Created by Rhys Morgan on 17/01/2024.
//

import AbilityList
import ComposableArchitecture
import PokedexAPI
import XCTest

@MainActor
final class AbilityListTests: XCTestCase {
  struct TestError: Error {
    var localizedDescription: String {
      "Test Error"
    }
  }

  func testInitialise_Success() async {
    let store = TestStore(initialState: AbilityList.State(abilities: [])) {
      AbilityList()
    } withDependencies: {
      $0.apiClient.getAllAbilities = { Ability.mockList }
    }

    await store.send(.view(.initialise)) {
      $0.isLoading = true
    }

    await store.receive(\.didReceiveAbilities.success, Ability.mockList) {
      $0.isLoading = false
      $0.abilities = IdentifiedArray(uniqueElements: Ability.mockList)
    }
  }

  func testInitialise_Failure() async {
    let store = TestStore(initialState: AbilityList.State(abilities: [])) {
      AbilityList()
    } withDependencies: {
      $0.apiClient.getAllAbilities = { throw TestError() }
    }

    await store.send(.view(.initialise)) {
      $0.isLoading = true
    }

    await store.receive(\.didReceiveAbilities.failure) {
      $0.isLoading = false
      $0.alert = .error(TestError())
    }

    await store.send(.alert(.dismiss)) {
      $0.alert = nil
    }
  }
}

extension Ability {
  static let mockList: [Self] = [
    Ability(id: 1, name: "Overgrow", isHidden: false),
    Ability(id: 2, name: "Blaze", isHidden: false),
    Ability(id: 3, name: "Torrent", isHidden: false),
  ]
}
