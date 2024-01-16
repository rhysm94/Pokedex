//
//  AbilityListView.swift
//  AbilityList
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import SwiftUI

public struct AbilityListView: View {
  public let store: StoreOf<AbilityList>

  public var body: some View {
    WithViewStore(store, observe: { $0 }, send: { .view($0) }) { viewStore in
      List(viewStore.abilities) { ability in
        Text(ability.name)
      }
    }
    .navigationTitle("Abilities")
  }
}

#Preview {
  NavigationStack {
    AbilityListView(
      store: Store(
        initialState: AbilityList.State(
          abilities: [
            Ability(id: 1, name: "Overgrow", isHidden: false),
            Ability(id: 2, name: "Blaze", isHidden: false),
            Ability(id: 3, name: "Torrent", isHidden: false),
          ]
        )
      ) {
        AbilityList()
      }
    )
  }
}
