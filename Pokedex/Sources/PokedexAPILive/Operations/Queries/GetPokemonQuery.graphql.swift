// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetPokemonQuery: GraphQLQuery {
  public static let operationName: String = "GetPokemon"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetPokemon($pokemonID: Int!) { pokemon: pokemon_v2_pokemonspecies_by_pk(id: $pokemonID) { __typename evolves_from_species_id name: pokemon_v2_pokemonspeciesnames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename name } evolution_chain: pokemon_v2_evolutionchain { __typename id species: pokemon_v2_pokemonspecies { __typename id pokemon_v2_pokemonspeciesnames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename name } } } pokemon_data: pokemon_v2_pokemons { __typename types: pokemon_v2_pokemontypes { __typename type: pokemon_v2_type { __typename name: pokemon_v2_typenames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename name } } } abilities: pokemon_v2_pokemonabilities { __typename id name: pokemon_v2_ability { __typename id name } is_hidden } moves: pokemon_v2_pokemonmoves { __typename id version_group: pokemon_v2_versiongroup { __typename id name } move: pokemon_v2_move { __typename name: pokemon_v2_movenames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename id name } type: pokemon_v2_type { __typename pokemon_v2_typenames(where: { pokemon_v2_language: { iso639: { _eq: "en" } } }) { __typename name } } } } } } }"#
    ))

  public var pokemonID: Int

  public init(pokemonID: Int) {
    self.pokemonID = pokemonID
  }

  public var __variables: Variables? { ["pokemonID": pokemonID] }

  public struct Data: PokedexAPILive.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Query_root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon_v2_pokemonspecies_by_pk", alias: "pokemon", Pokemon?.self, arguments: ["id": .variable("pokemonID")]),
    ] }

    /// fetch data from the table: "pokemon_v2_pokemonspecies" using primary key columns
    public var pokemon: Pokemon? { __data["pokemon"] }

    /// Pokemon
    ///
    /// Parent Type: `Pokemon_v2_pokemonspecies`
    public struct Pokemon: PokedexAPILive.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonspecies }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("evolves_from_species_id", Int?.self),
        .field("pokemon_v2_pokemonspeciesnames", alias: "name", [Name].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
        .field("pokemon_v2_evolutionchain", alias: "evolution_chain", Evolution_chain?.self),
        .field("pokemon_v2_pokemons", alias: "pokemon_data", [Pokemon_datum].self),
      ] }

      public var evolves_from_species_id: Int? { __data["evolves_from_species_id"] }
      /// An array relationship
      public var name: [Name] { __data["name"] }
      /// An object relationship
      public var evolution_chain: Evolution_chain? { __data["evolution_chain"] }
      /// An array relationship
      public var pokemon_data: [Pokemon_datum] { __data["pokemon_data"] }

      /// Pokemon.Name
      ///
      /// Parent Type: `Pokemon_v2_pokemonspeciesname`
      public struct Name: PokedexAPILive.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonspeciesname }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
        ] }

        public var name: String { __data["name"] }
      }

      /// Pokemon.Evolution_chain
      ///
      /// Parent Type: `Pokemon_v2_evolutionchain`
      public struct Evolution_chain: PokedexAPILive.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_evolutionchain }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Int.self),
          .field("pokemon_v2_pokemonspecies", alias: "species", [Specy].self),
        ] }

        public var id: Int { __data["id"] }
        /// An array relationship
        public var species: [Specy] { __data["species"] }

        /// Pokemon.Evolution_chain.Specy
        ///
        /// Parent Type: `Pokemon_v2_pokemonspecies`
        public struct Specy: PokedexAPILive.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonspecies }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("pokemon_v2_pokemonspeciesnames", [Pokemon_v2_pokemonspeciesname].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
          ] }

          public var id: Int { __data["id"] }
          /// An array relationship
          public var pokemon_v2_pokemonspeciesnames: [Pokemon_v2_pokemonspeciesname] { __data["pokemon_v2_pokemonspeciesnames"] }

          /// Pokemon.Evolution_chain.Specy.Pokemon_v2_pokemonspeciesname
          ///
          /// Parent Type: `Pokemon_v2_pokemonspeciesname`
          public struct Pokemon_v2_pokemonspeciesname: PokedexAPILive.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonspeciesname }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }
        }
      }

      /// Pokemon.Pokemon_datum
      ///
      /// Parent Type: `Pokemon_v2_pokemon`
      public struct Pokemon_datum: PokedexAPILive.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemon }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("pokemon_v2_pokemontypes", alias: "types", [Type_SelectionSet].self),
          .field("pokemon_v2_pokemonabilities", alias: "abilities", [Ability].self),
          .field("pokemon_v2_pokemonmoves", alias: "moves", [Move].self),
        ] }

        /// An array relationship
        public var types: [Type_SelectionSet] { __data["types"] }
        /// An array relationship
        public var abilities: [Ability] { __data["abilities"] }
        /// An array relationship
        public var moves: [Move] { __data["moves"] }

        /// Pokemon.Pokemon_datum.Type_SelectionSet
        ///
        /// Parent Type: `Pokemon_v2_pokemontype`
        public struct Type_SelectionSet: PokedexAPILive.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemontype }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("pokemon_v2_type", alias: "type", Type_SelectionSet?.self),
          ] }

          /// An object relationship
          public var type: Type_SelectionSet? { __data["type"] }

          /// Pokemon.Pokemon_datum.Type_SelectionSet.Type_SelectionSet
          ///
          /// Parent Type: `Pokemon_v2_type`
          public struct Type_SelectionSet: PokedexAPILive.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_type }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("pokemon_v2_typenames", alias: "name", [Name].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
            ] }

            /// An array relationship
            public var name: [Name] { __data["name"] }

            /// Pokemon.Pokemon_datum.Type_SelectionSet.Type_SelectionSet.Name
            ///
            /// Parent Type: `Pokemon_v2_typename`
            public struct Name: PokedexAPILive.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_typename }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("name", String.self),
              ] }

              public var name: String { __data["name"] }
            }
          }
        }

        /// Pokemon.Pokemon_datum.Ability
        ///
        /// Parent Type: `Pokemon_v2_pokemonability`
        public struct Ability: PokedexAPILive.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonability }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("pokemon_v2_ability", alias: "name", Name?.self),
            .field("is_hidden", Bool.self),
          ] }

          public var id: Int { __data["id"] }
          /// An object relationship
          public var name: Name? { __data["name"] }
          public var is_hidden: Bool { __data["is_hidden"] }

          /// Pokemon.Pokemon_datum.Ability.Name
          ///
          /// Parent Type: `Pokemon_v2_ability`
          public struct Name: PokedexAPILive.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_ability }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", Int.self),
              .field("name", String.self),
            ] }

            public var id: Int { __data["id"] }
            public var name: String { __data["name"] }
          }
        }

        /// Pokemon.Pokemon_datum.Move
        ///
        /// Parent Type: `Pokemon_v2_pokemonmove`
        public struct Move: PokedexAPILive.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonmove }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("pokemon_v2_versiongroup", alias: "version_group", Version_group?.self),
            .field("pokemon_v2_move", alias: "move", Move?.self),
          ] }

          public var id: Int { __data["id"] }
          /// An object relationship
          public var version_group: Version_group? { __data["version_group"] }
          /// An object relationship
          public var move: Move? { __data["move"] }

          /// Pokemon.Pokemon_datum.Move.Version_group
          ///
          /// Parent Type: `Pokemon_v2_versiongroup`
          public struct Version_group: PokedexAPILive.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_versiongroup }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", Int.self),
              .field("name", String.self),
            ] }

            public var id: Int { __data["id"] }
            public var name: String { __data["name"] }
          }

          /// Pokemon.Pokemon_datum.Move.Move
          ///
          /// Parent Type: `Pokemon_v2_move`
          public struct Move: PokedexAPILive.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_move }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("pokemon_v2_movenames", alias: "name", [Name].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
              .field("pokemon_v2_type", alias: "type", Type_SelectionSet?.self),
            ] }

            /// An array relationship
            public var name: [Name] { __data["name"] }
            /// An object relationship
            public var type: Type_SelectionSet? { __data["type"] }

            /// Pokemon.Pokemon_datum.Move.Move.Name
            ///
            /// Parent Type: `Pokemon_v2_movename`
            public struct Name: PokedexAPILive.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_movename }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", Int.self),
                .field("name", String.self),
              ] }

              public var id: Int { __data["id"] }
              public var name: String { __data["name"] }
            }

            /// Pokemon.Pokemon_datum.Move.Move.Type_SelectionSet
            ///
            /// Parent Type: `Pokemon_v2_type`
            public struct Type_SelectionSet: PokedexAPILive.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_type }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("pokemon_v2_typenames", [Pokemon_v2_typename].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
              ] }

              /// An array relationship
              public var pokemon_v2_typenames: [Pokemon_v2_typename] { __data["pokemon_v2_typenames"] }

              /// Pokemon.Pokemon_datum.Move.Move.Type_SelectionSet.Pokemon_v2_typename
              ///
              /// Parent Type: `Pokemon_v2_typename`
              public struct Pokemon_v2_typename: PokedexAPILive.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_typename }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("name", String.self),
                ] }

                public var name: String { __data["name"] }
              }
            }
          }
        }
      }
    }
  }
}
