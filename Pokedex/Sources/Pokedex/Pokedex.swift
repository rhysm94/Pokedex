//
//  Pokedex.swift
//  Pokedex
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture
import PokemonList

@Reducer
public struct Pokedex {
  public struct State: Equatable {
    @BindingState public var currentTab: Tab

    public var pokemonList: PokemonList.State

    public init(
      currentTab: Tab = .pokemon,
      pokemonList: PokemonList.State = .init(pokemon: [])
    ) {
      self.currentTab = currentTab
      self.pokemonList = pokemonList
    }

    public enum Tab {
      case pokemon
    }
  }

  public enum Action: BindableAction {
    case view(ViewAction)
    case binding(BindingAction<State>)

    case pokemonList(PokemonList.Action)

    public enum ViewAction {
      case initialise
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Reduce { state, action in
      switch action {
      case .view(.initialise):
        return .none

      case .pokemonList:
        return .none

      case .binding:
        return .none
      }
    }
  }
}
