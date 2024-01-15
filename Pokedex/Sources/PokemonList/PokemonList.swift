//
//  PokemonList.swift
//  PokemonList
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct PokemonList {
  public struct State: Equatable {
    public var pokemon: IdentifiedArrayOf<PokemonListEntry>
    public var presentedPokemon: PokemonListEntry?

    public init(
      pokemon: IdentifiedArrayOf<PokemonListEntry>,
      presentedPokemon: PokemonListEntry? = nil
    ) {
      self.pokemon = pokemon
      self.presentedPokemon = presentedPokemon
    }
  }

  public enum Action {
    case view(ViewAction)

    public enum ViewAction {
      case initialise
      case didTapPokemon(PokemonListEntry.ID)
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        return .none

      case let .view(.didTapPokemon(pokemonID)):
        guard let pokemon = state.pokemon[id: pokemonID] else { return .none }
        state.presentedPokemon = pokemon
        return .none
      }
    }
  }
}
