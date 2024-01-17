//
//  AbilityList.swift
//  AbilityList
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import ViewAbility

@Reducer
public struct AbilityList {
  public struct State: Equatable {
    public var abilities: IdentifiedArrayOf<Ability>
    @PresentationState public var viewAbility: ViewAbility.State?
    public var isLoading: Bool

    public init(
      abilities: IdentifiedArrayOf<Ability>,
      viewAbility: ViewAbility.State? = nil,
      isLoading: Bool = false
    ) {
      self.abilities = abilities
      self.viewAbility = viewAbility
      self.isLoading = isLoading
    }
  }

  public enum Action {
    case didReceiveAbilities(Result<[Ability], Error>)
    case view(ViewAction)

    case viewAbility(PresentationAction<ViewAbility.Action>)

    public enum ViewAction {
      case initialise
      case didSelectAbility(Ability.ID)
    }
  }

  public init() {}

  @Dependency(\.apiClient) var apiClient

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        state.isLoading = true
        return .run { send in
          await send(
            .didReceiveAbilities(
              Result { try await apiClient.getAllAbilities() }
            )
          )
        }

      case let .view(.didSelectAbility(abilityID)):
        guard let ability = state.abilities[id: abilityID] else { return .none }
        state.viewAbility = ViewAbility.State(abilityID: abilityID, name: ability.name, isLoading: false)
        return .none

      case let .didReceiveAbilities(.success(abilities)):
        state.isLoading = false
        state.abilities = IdentifiedArray(uniqueElements: abilities)
        return .none

      case let .didReceiveAbilities(.failure(error)):
        state.isLoading = false
        print("Received error from API: \(error.localizedDescription)")
        return .none

      case .viewAbility:
        return .none
      }
    }
    .ifLet(\.$viewAbility, action: \.viewAbility) {
      ViewAbility()
    }
  }
}
