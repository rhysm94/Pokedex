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
  public struct State: Hashable {
    public var loadingState: LoadingState
    @PresentationState public var nested: ViewPokemon.State?

    var pokemonID: Int {
      switch loadingState {
      case .loading(let pokemon):
        pokemon.id
      case .loaded(let fullPokemon):
        fullPokemon.id
      }
    }

    public init(
      loadingState: LoadingState,
      nested: ViewPokemon.State? = nil
    ) {
      self.loadingState = loadingState
      self.nested = nested
    }
  }

  public enum LoadingState: Hashable {
    case loading(Pokemon)
    case loaded(FullPokemon)
  }

  public enum Action {
    case view(ViewAction)
    case receiveFullPokemon(Result<FullPokemon, Error>)
    indirect case viewPokemon(PresentationAction<Action>)

    public enum ViewAction {
      case initialise
      case didTapPokemon(Int)
    }
  }

  public init() {}

  @Dependency(\.apiClient) var apiClient

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        guard case let .loading(pokemon) = state.loadingState else { return .none }
        return .run { send in
          await send(
            .receiveFullPokemon(
              Result { try await apiClient.getPokemon(pokemonID: pokemon.id) }
            )
          )
        }

      case let .view(.didTapPokemon(tappedID)):
        guard
          state.pokemonID != tappedID,
          case let .loaded(pokemon) = state.loadingState,
          let tappedPokemon = pokemon.evolutionChain.species.first(where: { $0.id == tappedID })
        else {
          return .none
        }

        state.nested = .init(loadingState: .loading(tappedPokemon))
        return .none

      case let .receiveFullPokemon(.success(pokemon)):
        state.loadingState = .loaded(pokemon)
        return .none

      case let .receiveFullPokemon(.failure(error)):
        print(error.localizedDescription)
        return .none

      case .viewPokemon:
        return .none
      }
    }
    .ifLet(\.$nested, action: \.viewPokemon) {
      ViewPokemon()
    }
  }
}
