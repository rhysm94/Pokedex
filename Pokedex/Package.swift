// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Pokedex",
  products: [
    .library(
      name: "Pokedex",
      targets: ["Pokedex"]
    ),
  ],
  targets: [
    .target(
      name: "Pokedex"
    ),
    .testTarget(
      name: "PokedexTests",
      dependencies: ["Pokedex"]
    ),
  ]
)
