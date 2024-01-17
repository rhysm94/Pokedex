//
//  PokemonList.swift
//  PokemonList
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import ViewPokemon

@Reducer
public struct PokemonList {
  public struct State: Equatable {
    public var pokemon: IdentifiedArrayOf<PokemonListEntry>
    @PresentationState public var presentedPokemon: ViewPokemon.State?
    @PresentationState public var alert: AlertState<Action.Alert>?
    public var isLoading: Bool

    public init(
      pokemon: IdentifiedArrayOf<PokemonListEntry>,
      presentedPokemon: ViewPokemon.State? = nil,
      alert: AlertState<Action.Alert>? = nil,
      isLoading: Bool = false
    ) {
      self.pokemon = pokemon
      self.presentedPokemon = presentedPokemon
      self.alert = alert
      self.isLoading = isLoading
    }

    mutating func initialise() -> Effect<Action> {
      @Dependency(\.apiClient) var apiClient

      isLoading = true

      return .run { send in
        await send(
          .didReceivePokemon(
            Result { try await apiClient.getAllPokemon() }
          )
        )
      }
    }
  }

  public enum Action {
    case view(ViewAction)
    case didReceivePokemon(Result<[Pokemon], Error>)
    case viewPokemon(PresentationAction<ViewPokemon.Action>)
    case alert(PresentationAction<Alert>)

    public enum ViewAction {
      case initialise
      case didTapPokemon(PokemonListEntry.ID)
    }

    public enum Alert {
      case retry
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        return state.initialise()

      case let .didReceivePokemon(.failure(error)):
        state.isLoading = false
        state.alert = .error(error)
        return .none

      case let .didReceivePokemon(.success(pokemon)):
        state.isLoading = false
        state.pokemon = IdentifiedArray(uniqueElements: pokemon.map(PokemonListEntry.init))
        return .none

      case let .view(.didTapPokemon(pokemonID)):
        guard let pokemon = state.pokemon[id: pokemonID] else { return .none }
        state.presentedPokemon = .init(
          loadingState: .loading(
            Pokemon(id: pokemonID, name: pokemon.name, thumbnailURL: pokemon.imageURL)
          )
        )
        return .none

      case .alert(.presented(.retry)):
        return state.initialise()

      case .viewPokemon, .alert:
        return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
    .ifLet(\.$presentedPokemon, action: \.viewPokemon) {
      ViewPokemon()
    }
  }
}

private extension PokemonListEntry {
  init(pokemon: Pokemon) {
    self.init(id: pokemon.id.rawValue, name: pokemon.name, imageURL: pokemon.thumbnailURL)
  }
}
