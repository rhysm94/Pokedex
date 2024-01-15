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
    .library(name: "PokemonList", targets: ["PokemonList"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.6.0")
  ],
  targets: [
    .target(
      name: "Pokedex",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "PokedexTests",
      dependencies: ["Pokedex"]
    ),
    .target(
      name: "PokemonList",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    )
  ]
)
