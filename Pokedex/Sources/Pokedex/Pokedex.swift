//
//  Pokedex.swift
//  Pokedex
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture
import AbilityList
import PokemonList

@Reducer
public struct Pokedex {
  public struct State: Equatable {
    @BindingState public var currentTab: Tab

    public var pokemonList: PokemonList.State
    public var abilityList: AbilityList.State

    public init(
      currentTab: Tab = .pokemon,
      pokemonList: PokemonList.State = .init(pokemon: []),
      abilityList: AbilityList.State = .init(abilities: [])
    ) {
      self.currentTab = currentTab
      self.pokemonList = pokemonList
      self.abilityList = abilityList
    }

    public enum Tab {
      case pokemon
      case abilities
    }
  }

  public enum Action: BindableAction {
    case binding(BindingAction<State>)

    case pokemonList(PokemonList.Action)
    case abilityList(AbilityList.Action)
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Scope(state: \.pokemonList, action: \.pokemonList) {
      PokemonList()
    }

    Scope(state: \.abilityList, action: \.abilityList) {
      AbilityList()
    }
  }
}
