//
//  AlertStateHelper.swift
//  PokemonList
//
//  Created by Rhys Morgan on 17/01/2024.
//

import ComposableArchitecture

public extension AlertState<PokemonList.Action.Alert> {
  static func error(_ error: any Error) -> Self {
    Self(
      title: { TextState("Error") },
      actions: {
        ButtonState(action: .retry) {
          TextState("Retry")
        }

        ButtonState(role: .cancel) {
          TextState("Cancel")
        }
      },
      message: {
        TextState(error.localizedDescription)
      }
    )
  }
}

