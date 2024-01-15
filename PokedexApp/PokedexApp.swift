//
//  PokedexApp.swift
//  PokedexApp
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture
import Pokedex
import PokedexAPI
import SwiftUI

@main
struct PokedexApp: App {
  var body: some Scene {
    WindowGroup {
      PokedexView(
        store: Store(initialState: Pokedex.State()) {
          Pokedex()
        } withDependencies: {
          $0.apiClient.getAllPokemon = {
            [
              Pokemon(id: 1, name: "Bulbasaur", thumbnailURL: nil),
              Pokemon(id: 2, name: "Ivysaur", thumbnailURL: nil),
              Pokemon(id: 3, name: "Venusaur", thumbnailURL: nil),
              Pokemon(id: 4, name: "Charmander", thumbnailURL: nil),
              Pokemon(id: 5, name: "Charmeleon", thumbnailURL: nil),
              Pokemon(id: 6, name: "Charizard", thumbnailURL: nil),
              Pokemon(id: 7, name: "Squirtle", thumbnailURL: nil),
              Pokemon(id: 8, name: "Wartortle", thumbnailURL: nil),
              Pokemon(id: 9, name: "Blastoise", thumbnailURL: nil)
            ]
          }
        }
      )
    }
  }
}
