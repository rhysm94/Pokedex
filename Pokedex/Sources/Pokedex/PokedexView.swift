//
//  PokedexView.swift
//  Pokedex
//
//  Created by Rhys Morgan on 12/01/2024.
//

import ComposableArchitecture
import SwiftUI

public struct PokedexView: View {
  let store: StoreOf<Pokedex>

  public init(store: StoreOf<Pokedex>) {
    self.store = store
  }

  public var body: some View {
    Text("Hello, World!")
  }
}
