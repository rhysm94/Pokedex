//
//  ViewAbility.swift
//  ViewAbility
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI

@Reducer
public struct ViewAbility {
  public struct State: Equatable {
    public var abilityID: Int
    public var name: String
    public var flavourText: String?
    public var pokemonWithAbility: [Pokemon] = []
    public var isLoading: Bool

    public init(
      abilityID: Int,
      name: String,
      flavourText: String? = nil,
      pokemonWithAbility: [Pokemon] = [],
      isLoading: Bool
    ) {
      self.abilityID = abilityID
      self.name = name
      self.flavourText = flavourText
      self.pokemonWithAbility = pokemonWithAbility
      self.isLoading = isLoading
    }
  }

  public enum Action {
    case didReceiveFullAbility(Result<FullAbility, Error>)
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
        state.isLoading = true
        return .run { [abilityID = state.abilityID] send in
          await send(
            .didReceiveFullAbility(
              Result { try await apiClient.getAbility(abilityID: abilityID) }
            )
          )
        }

      case let .didReceiveFullAbility(.success(fullAbility)):
        state.isLoading = false
        state.flavourText = fullAbility.flavourText
        state.pokemonWithAbility = fullAbility.pokemonWithAbility
        return .none

      case .didReceiveFullAbility(.failure):
        return .none
      }
    }
  }
}
