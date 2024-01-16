//
//  ViewPokemon.swift
//  ViewPokemon
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI

@Reducer
public struct ViewPokemon {
  public enum State: Hashable {
    case loading(Pokemon)
    case loaded(FullPokemon)
  }

  public enum Action {
    case view(ViewAction)
    case receiveFullPokemon(Result<FullPokemon, Error>)

    public enum ViewAction {
      case initialise
    }
  }

  public init() {}

  @Dependency(\.apiClient) var apiClient

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch (state, action) {
      case let (.loading(pokemon), .view(.initialise)):
        return .run { send in
          await send(
            .receiveFullPokemon(
              Result { try await apiClient.getPokemon(pokemonID: pokemon.id) }
            )
          )
        }

      case (_, .view(.initialise)):
        return .none

      case let (_, .receiveFullPokemon(.success(pokemon))):
        state = .loaded(pokemon)
        return .none

      case let (_, .receiveFullPokemon(.failure(error))):
        print(error.localizedDescription)
        return .none
      }
    }
  }
}
