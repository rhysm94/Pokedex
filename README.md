# Pokédex

This is a rapidly evolving demo of an app built with the following tools:

- [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) for state management and general architecture
- [Swift Dependencies](https://github.com/pointfreeco/swift-dependencies) for dependency injection
- [Apollo iOS](https://github.com/apollographql/apollo-ios) for GraphQL API communication
- [Swift Tagged](https://github.com/pointfreeco/swift-tagged) for safer ID types

The app communicates with [PokéAPI](https://pokeapi.co) using their beta GraphQL endpoint, as this allows retrieval of data in almost whichever configuration the user wants, rather than the more static data layout that their RESTful API provides.
Apollo has a CLI tool, which generates strongly-typed queries for use with the Apollo Client. In future, I will seek to generate these files at build-time instead of generating them externally.
