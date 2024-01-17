// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Pokedex",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
    .watchOS(.v10)
  ],
  products: [
    .library(name: "Pokedex", targets: ["Pokedex"]),
    .library(name: "PokemonList", targets: ["PokemonList"]),
    .library(name: "ViewPokemon", targets: ["ViewPokemon"]),
    .library(name: "AbilityList", targets: ["AbilityList"]),
    .library(name: "ViewAbility", targets: ["ViewAbility"]),
    .library(name: "PokedexAPI", targets: ["PokedexAPI"]),
    .library(name: "PokedexAPILive", targets: ["PokedexAPILive"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.6.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "Pokedex",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "PokemonList",
        "AbilityList",
        "PokedexAPILive"
      ]
    ),
    .testTarget(
      name: "PokedexTests",
      dependencies: ["Pokedex"]
    ),
    .target(
      name: "PokemonList",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "PokedexAPI",
        "ViewPokemon"
      ]
    ),
    .testTarget(
      name: "PokemonListTests",
      dependencies: [
        "PokemonList",
        "PokedexAPI"
      ]
    ),
    .target(
      name: "ViewPokemon",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "PokedexAPI"
      ]
    ),
    .testTarget(
      name: "ViewPokemonTests",
      dependencies: ["ViewPokemon"]
    ),
    .target(
      name: "PokedexAPI",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies"),
      ]
    ),
    .target(
      name: "PokedexAPILive",
      dependencies: [
        "PokedexAPI",
        .product(name: "Apollo", package: "apollo-ios")
      ]
    ),
    .target(
      name: "AbilityList",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "PokedexAPI",
        "ViewAbility"
      ]
    ),
    .target(
      name: "ViewAbility",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "PokedexAPI"
      ]
    )
  ]
)
