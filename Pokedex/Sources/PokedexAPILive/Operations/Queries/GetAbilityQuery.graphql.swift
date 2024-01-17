// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAbilityQuery: GraphQLQuery {
  public static let operationName: String = "GetAbility"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAbility($id: Int!) { pokemon_v2_ability_by_pk(id: $id) { __typename names: pokemon_v2_abilitynames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename name } flavorText: pokemon_v2_abilityflavortexts( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } order_by: { version_group_id: desc } ) { __typename text: flavor_text versionGroupID: version_group_id } pokemon: pokemon_v2_pokemonabilities { __typename id: pokemon_id pokemonData: pokemon_v2_pokemon { __typename spriteName: name data: pokemon_v2_pokemonspecy { __typename names: pokemon_v2_pokemonspeciesnames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename name } } } } } }"#
    ))

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: PokedexAPILive.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Query_root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon_v2_ability_by_pk", Pokemon_v2_ability_by_pk?.self, arguments: ["id": .variable("id")]),
    ] }

    /// fetch data from the table: "pokemon_v2_ability" using primary key columns
    public var pokemon_v2_ability_by_pk: Pokemon_v2_ability_by_pk? { __data["pokemon_v2_ability_by_pk"] }

    /// Pokemon_v2_ability_by_pk
    ///
    /// Parent Type: `Pokemon_v2_ability`
    public struct Pokemon_v2_ability_by_pk: PokedexAPILive.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_ability }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("pokemon_v2_abilitynames", alias: "names", [Name].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
        .field("pokemon_v2_abilityflavortexts", alias: "flavorText", [FlavorText].self, arguments: [
          "where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]],
          "order_by": ["version_group_id": "desc"]
        ]),
        .field("pokemon_v2_pokemonabilities", alias: "pokemon", [Pokemon].self),
      ] }

      /// An array relationship
      public var names: [Name] { __data["names"] }
      /// An array relationship
      public var flavorText: [FlavorText] { __data["flavorText"] }
      /// An array relationship
      public var pokemon: [Pokemon] { __data["pokemon"] }

      /// Pokemon_v2_ability_by_pk.Name
      ///
      /// Parent Type: `Pokemon_v2_abilityname`
      public struct Name: PokedexAPILive.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_abilityname }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
        ] }

        public var name: String { __data["name"] }
      }

      /// Pokemon_v2_ability_by_pk.FlavorText
      ///
      /// Parent Type: `Pokemon_v2_abilityflavortext`
      public struct FlavorText: PokedexAPILive.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_abilityflavortext }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("flavor_text", alias: "text", String.self),
          .field("version_group_id", alias: "versionGroupID", Int?.self),
        ] }

        public var text: String { __data["text"] }
        public var versionGroupID: Int? { __data["versionGroupID"] }
      }

      /// Pokemon_v2_ability_by_pk.Pokemon
      ///
      /// Parent Type: `Pokemon_v2_pokemonability`
      public struct Pokemon: PokedexAPILive.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonability }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("pokemon_id", alias: "id", Int?.self),
          .field("pokemon_v2_pokemon", alias: "pokemonData", PokemonData?.self),
        ] }

        public var id: Int? { __data["id"] }
        /// An object relationship
        public var pokemonData: PokemonData? { __data["pokemonData"] }

        /// Pokemon_v2_ability_by_pk.Pokemon.PokemonData
        ///
        /// Parent Type: `Pokemon_v2_pokemon`
        public struct PokemonData: PokedexAPILive.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemon }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", alias: "spriteName", String.self),
            .field("pokemon_v2_pokemonspecy", alias: "data", Data?.self),
          ] }

          public var spriteName: String { __data["spriteName"] }
          /// An object relationship
          public var data: Data? { __data["data"] }

          /// Pokemon_v2_ability_by_pk.Pokemon.PokemonData.Data
          ///
          /// Parent Type: `Pokemon_v2_pokemonspecies`
          public struct Data: PokedexAPILive.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonspecies }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("pokemon_v2_pokemonspeciesnames", alias: "names", [Name].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
            ] }

            /// An array relationship
            public var names: [Name] { __data["names"] }

            /// Pokemon_v2_ability_by_pk.Pokemon.PokemonData.Data.Name
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
          }
        }
      }
    }
  }
}
