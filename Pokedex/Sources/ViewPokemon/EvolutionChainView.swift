//
//  EvolutionChainView.swift
//  ViewPokemon
//
//  Created by Rhys Morgan on 16/01/2024.
//

import SwiftUI
import PokedexAPI

public struct EvolutionChainView: View {
  let chain: FullPokemon.EvolutionChain
  let didTapPokemonID: (_ pokemonID: Int) -> Void

  public var body: some View {
    LazyVGrid(columns: [.init(.adaptive(minimum: 80, maximum: 150))]) {
      ForEach(chain.species, id: \.id) { pokemon in
        Button {
          didTapPokemonID(pokemon.id)
        } label: {
          VStack {
            AsyncImage(url: pokemon.thumbnailURL) { image in
              image
                .resizable()
                .scaledToFit()
            } placeholder: {
              Image(systemName: "circle")
            }
            .frame(width: 80)

            Text(pokemon.name)
          }
        }
      }
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  EvolutionChainView(
    chain: .init(
      id: 1,
      species: [
        Pokemon(
          id: 1,
          name: "Bulbasaur",
          thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/bulbasaur.png")
        ),
        Pokemon(
          id: 2,
          name: "Ivysaur",
          thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/ivysaur.png")
        ),
        Pokemon(
          id: 3,
          name: "Venusaur",
          thumbnailURL: URL(string: "https://img.pokemondb.net/sprites/scarlet-violet/normal/venusaur.png")
        )
      ]
    ),
    didTapPokemonID: { id in
      print("Did Tap ID: \(id)")
    }
  )
  .previewDisplayName("Bulbasaur")
}
