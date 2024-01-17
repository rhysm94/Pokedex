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
    public var abilityID: Ability.ID
    public var name: String
    public var flavourText: String?
    public var pokemonWithAbility: IdentifiedArrayOf<Pokemon>
    public var isLoading: Bool

    @PresentationState public var selectedPokemon: ViewPokemon.State?
    @PresentationState public var alert: AlertState<Action.Alert>?

    public init(
      abilityID: Ability.ID,
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

    mutating func initialise() -> Effect<Action> {
      @Dependency(\.apiClient) var apiClient
      isLoading = true
      return .run { [abilityID] send in
        await send(
          .didReceiveFullAbility(
            Result { try await apiClient.getAbility(abilityID: abilityID) }
          )
        )
      }
    }
  }

  public enum Action {
    case didReceiveFullAbility(Result<FullAbility, Error>)
    case view(ViewAction)

    case viewPokemon(PresentationAction<ViewPokemon.Action>)
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

      case let .didReceiveFullAbility(.failure(error)):
        state.alert = .error(error)
        return .none

      case .alert(.presented(.retry)):
        return state.initialise()

      case .viewPokemon, .alert:
        return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
    .ifLet(\.$selectedPokemon, action: \.viewPokemon) {
      ViewPokemon()
    }
  }
}
