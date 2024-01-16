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

    public init(
      pokemon: IdentifiedArrayOf<PokemonListEntry>,
      presentedPokemon: ViewPokemon.State? = nil
    ) {
      self.pokemon = pokemon
      self.presentedPokemon = presentedPokemon
    }
  }

  public enum Action {
    case view(ViewAction)
    case didReceivePokemon(Result<[Pokemon], Error>)
    case viewPokemon(PresentationAction<ViewPokemon.Action>)

    public enum ViewAction {
      case initialise
      case didTapPokemon(PokemonListEntry.ID)
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
        state.presentedPokemon = .init(
          loadingState: .loading(
            Pokemon(id: pokemonID, name: pokemon.name, thumbnailURL: pokemon.imageURL)
          )
        )
        return .none

      case .viewPokemon:
        return .none
      }
    }
    .ifLet(\.$presentedPokemon, action: \.viewPokemon) {
      ViewPokemon()
    }
  }
}

private extension PokemonListEntry {
  init(pokemon: Pokemon) {
    self.init(id: pokemon.id, name: pokemon.name, imageURL: pokemon.thumbnailURL)
  }
}
