//
//  AbilityListView.swift
//  AbilityList
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import SwiftUI
import ViewAbility

public struct AbilityListView: View {
  let store: StoreOf<AbilityList>

  public init(store: StoreOf<AbilityList>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack {
      WithViewStore(store, observe: { $0 }, send: { .view($0) }) { viewStore in
        List {
          ForEach(viewStore.abilities) { ability in
            Button(ability.name) {
              viewStore.send(.didSelectAbility(ability.id))
            }
            .buttonStyle(.plain)
          }

          if viewStore.isLoading {
            HStack {
              Spacer()

              ProgressView()
                .progressViewStyle(.circular)

              Spacer()
            }
          }
        }
        .navigationDestination(
          store: store.scope(state: \.$viewAbility, action: \.viewAbility),
          destination: ViewAbilityView.init
        )
        .task {
          await viewStore.send(.initialise).finish()
        }
      }
      .navigationTitle("Abilities")
    }
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
