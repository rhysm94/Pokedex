//
//  AbilityList.swift
//  AbilityList
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI

@Reducer
public struct AbilityList {
  public struct State: Equatable {
    public var abilities: IdentifiedArrayOf<Ability>

    public init(abilities: IdentifiedArrayOf<Ability>) {
      self.abilities = abilities
    }
  }

  public enum Action {
    case didReceiveAbilities(Result<[Ability], Error>)
    case view(ViewAction)

    public enum ViewAction {
      case initialise
    }
  }

  public init() {}

  @Dependency(\.apiClient) var apiClient

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        return .run { send in
          await send(
            .didReceiveAbilities(
              Result { try await apiClient.getAllAbilities() }
            )
          )
        }

      case let .didReceiveAbilities(.success(abilities)):
        state.abilities = IdentifiedArray(uniqueElements: abilities)
        return .none

      case let .didReceiveAbilities(.failure(error)):
        print("Received error from API: \(error.localizedDescription)")
        return .none
      }
    }
  }
}
