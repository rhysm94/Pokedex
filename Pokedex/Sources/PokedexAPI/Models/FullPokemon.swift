//
//  FullPokemon.swift
//  PokedexAPI
//
//  Created by Rhys Morgan on 16/01/2024.
//

import Foundation

public struct FullPokemon: Hashable {
  public let id: Int
  public let name: String
  public let evolvesFrom: Int?
  public let evolutionChain: EvolutionChain

  public let typeOne: PokemonType
  public let typeTwo: PokemonType?

  public let abilities: [Ability]

  public let moves: [Move]

  public struct EvolutionChain: Hashable {
    public let id: Int
    public let species: [Pokemon]

    public init(id: Int, species: [Pokemon]) {
      self.id = id
      self.species = species
    }
  }

  public init(
    id: Int,
    name: String,
    evolvesFrom: Int?,
    evolutionChain: EvolutionChain,
    typeOne: PokemonType,
    typeTwo: PokemonType?,
    abilities: [Ability],
    moves: [Move]
  ) {
    self.id = id
    self.name = name
    self.evolvesFrom = evolvesFrom
    self.evolutionChain = evolutionChain
    self.typeOne = typeOne
    self.typeTwo = typeTwo
    self.abilities = abilities
    self.moves = moves
  }
}
