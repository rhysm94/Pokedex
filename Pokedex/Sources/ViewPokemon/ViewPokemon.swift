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
    public var pokemon: Pokemon
    public var fullPokemon: FullPokemon?
    @PresentationState public var nested: ViewPokemon.State?
    @PresentationState public var alert: AlertState<Action.Alert>?
    public var isLoading: Bool

    public init(
      pokemon: Pokemon,
      fullPokemon: FullPokemon? = nil,
      nested: ViewPokemon.State? = nil,
      alert: AlertState<Action.Alert>? = nil,
      isLoading: Bool = false
    ) {
      self.pokemon = pokemon
      self.fullPokemon = fullPokemon
      self.nested = nested
      self.alert = alert
      self.isLoading = isLoading
    }

    mutating func initialise() -> Effect<Action> {
      @Dependency(\.apiClient) var apiClient
      isLoading = true
      return .run { [pokemonID = pokemon.id] send in
        await send(
          .receiveFullPokemon(
            Result { try await apiClient.getPokemon(pokemonID: pokemonID) }
          )
        )
      }
    }
  }

  public enum Action {
    case view(ViewAction)
    case receiveFullPokemon(Result<FullPokemon, Error>)
    indirect case viewPokemon(PresentationAction<Action>)
    case alert(PresentationAction<Alert>)

    public enum ViewAction {
      case initialise
      case didTapPokemon(Pokemon.ID)
    }

    public enum Alert {
      case retry
    }
  }

  public init() {}

  @Dependency(\.apiClient) var apiClient

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        return state.initialise()

      case let .view(.didTapPokemon(tappedID)):
        guard
          state.pokemon.id != tappedID,
          let fullPokemon = state.fullPokemon,
          let tappedPokemon = fullPokemon.evolutionChain.species.first(where: { $0.id == tappedID })
        else {
          return .none
        }

        state.nested = .init(pokemon: tappedPokemon)
        return .none

      case let .receiveFullPokemon(.success(pokemon)):
        state.isLoading = false
        state.fullPokemon = pokemon
        return .none

      case let .receiveFullPokemon(.failure(error)):
        state.isLoading = false
        state.alert = .error(error)
        return .none

      case .alert(.presented(.retry)):
        return state.initialise()

      case .viewPokemon, .alert:
        return .none
      }
    }
    .ifLet(\.$nested, action: \.viewPokemon) {
      ViewPokemon()
    }
  }
}
