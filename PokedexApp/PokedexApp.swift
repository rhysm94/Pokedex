//
//  PokedexApp.swift
//  PokedexApp
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture
import Pokedex
import SwiftUI

@main
struct PokedexApp: App {
  var body: some Scene {
    WindowGroup {
      PokedexView(
        store: Store(initialState: Pokedex.State()) {
          Pokedex()
        }
      )
    }
  }
}
