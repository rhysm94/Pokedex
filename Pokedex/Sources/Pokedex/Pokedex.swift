//
//  Pokedex.swift
//  Pokedex
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture

@Reducer
public struct Pokedex {
  public struct State: Equatable {
    @BindingState public var currentTab: Tab

    public init(currentTab: Tab = .pokemon) {
      self.currentTab = currentTab
    }

    public enum Tab {
      case pokemon
    }
  }

  public enum Action: BindableAction {
    case view(ViewAction)
    case binding(BindingAction<State>)

    public enum ViewAction {
      case initialise
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .view(.initialise):
        return .none
      }
    }
  }
}
