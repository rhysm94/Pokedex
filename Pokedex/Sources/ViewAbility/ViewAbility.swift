//
//  ViewAbility.swift
//  ViewAbility
//
//  Created by Rhys Morgan on 16/01/2024.
//

import ComposableArchitecture
import PokedexAPI
import ViewPokemon

@Reducer
public struct ViewAbility {
  public struct State: Equatable {
    public var abilityID: Int
    public var name: String
    public var flavourText: String?
    public var pokemonWithAbility: IdentifiedArrayOf<Pokemon>
    public var isLoading: Bool

    @PresentationState public var selectedPokemon: ViewPokemon.State?

    public init(
      abilityID: Int,
      name: String,
      flavourText: String? = nil,
      pokemonWithAbility: IdentifiedArrayOf<Pokemon> = [],
      isLoading: Bool
    ) {
      self.abilityID = abilityID
      self.name = name
      self.flavourText = flavourText
      self.pokemonWithAbility = pokemonWithAbility
      self.isLoading = isLoading
    }
  }

  public enum Action {
    case didReceiveFullAbility(Result<FullAbility, Error>)
    case view(ViewAction)

    case viewPokemon(PresentationAction<ViewPokemon.Action>)

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
        state.isLoading = true
        return .run { [abilityID = state.abilityID] send in
          await send(
            .didReceiveFullAbility(
              Result { try await apiClient.getAbility(abilityID: abilityID) }
            )
          )
        }

      case let .view(.didTapPokemon(pokemonID)):
        guard let pokemon = state.pokemonWithAbility[id: pokemonID] else {
          return .none
        }

        state.selectedPokemon = .init(loadingState: .loading(pokemon))
        return .none

      case let .didReceiveFullAbility(.success(fullAbility)):
        state.isLoading = false
        state.flavourText = fullAbility.flavourText
        state.pokemonWithAbility = IdentifiedArray(uniqueElements: fullAbility.pokemonWithAbility)
        return .none

      case .didReceiveFullAbility(.failure):
        // TODO: Fill in error state
        return .none

      case .viewPokemon:
        return .none
      }
    }
    .ifLet(\.$selectedPokemon, action: \.viewPokemon) {
      ViewPokemon()
    }
  }
}
