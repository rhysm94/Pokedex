//
//  AlertStateHelper.swift
//  AbilityList
//
//  Created by Rhys Morgan on 17/01/2024.
//

import ComposableArchitecture

public extension AlertState<AbilityList.Action.Alert> {
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
