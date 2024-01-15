//
//  PokemonList.swift
//  PokemonList
//
//  Created by Rhys Morgan on 15/01/2024.
//

import ComposableArchitecture
import Foundation

public struct PokemonListEntry: Identifiable, Hashable {
  public var id: UUID
  public var name: String

  public init(id: UUID, name: String) {
    self.id = id
    self.name = name
  }

  public init(name: String) {
    @Dependency(\.uuid) var uuid

    self.id = uuid()
    self.name = name
  }
}

@Reducer
public struct PokemonList {
  public struct State: Equatable {
    public var pokemon: IdentifiedArrayOf<PokemonListEntry>

    public init(pokemon: IdentifiedArrayOf<PokemonListEntry>) {
      self.pokemon = pokemon
    }
  }

  public enum Action {
    case view(ViewAction)

    public enum ViewAction {
      case initialise
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.initialise):
        return .none
      }
    }
  }
}
