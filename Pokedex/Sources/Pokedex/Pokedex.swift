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
    public init() {}
  }

  public enum Action {
    case view(ViewAction)

    public enum ViewAction {
      case initialise
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        return .none
      }
    }
  }
}
