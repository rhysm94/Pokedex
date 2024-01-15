//
//  PokemonList.swift
//  PokemonList
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import PokedexAPI

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
    case didReceivePokemon(Result<[Pokemon], Error>)

    public enum ViewAction {
      case initialise
      case didTapPokemon(PokemonListEntry.ID)
      case dismissPresentedPokemon
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
            .didReceivePokemon(
              Result { try await apiClient.getAllPokemon() }
            )
          )
        }

      case .didReceivePokemon(.failure):
        return .none

      case let .didReceivePokemon(.success(pokemon)):
        state.pokemon = IdentifiedArray(uniqueElements: pokemon.map(PokemonListEntry.init))
        return .none

      case let .view(.didTapPokemon(pokemonID)):
        guard let pokemon = state.pokemon[id: pokemonID] else { return .none }
        state.presentedPokemon = pokemon
        return .none

      case .view(.dismissPresentedPokemon):
        state.presentedPokemon = nil
        return .none
      }
    }
  }
}

private extension PokemonListEntry {
  init(pokemon: Pokemon) {
    self.init(id: pokemon.id, name: pokemon.name, imageURL: pokemon.thumbnailURL)
  }
}
