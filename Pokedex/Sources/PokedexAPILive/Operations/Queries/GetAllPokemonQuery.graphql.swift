// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAllPokemonQuery: GraphQLQuery {
  public static let operationName: String = "getAllPokemon"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query getAllPokemon { pokemonSpecies: pokemon_v2_pokemonspecies(order_by: { id: asc }) { __typename name id pokemon_v2_pokemonspeciesnames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename name } } }"#
    ))

  public init() {}

  public struct Data: PokedexAPILive.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Query_root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon_v2_pokemonspecies", alias: "pokemonSpecies", [PokemonSpecy].self, arguments: ["order_by": ["id": "asc"]]),
    ] }

    /// An array relationship
    public var pokemonSpecies: [PokemonSpecy] { __data["pokemonSpecies"] }

    /// PokemonSpecy
    ///
    /// Parent Type: `Pokemon_v2_pokemonspecies`
    public struct PokemonSpecy: PokedexAPILive.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_pokemonspecies }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String.self),
        .field("id", Int.self),
        .field("pokemon_v2_pokemonspeciesnames", [Pokemon_v2_pokemonspeciesname].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
      ] }

      public var name: String { __data["name"] }
      public var id: Int { __data["id"] }
      /// An array relationship
      public var pokemon_v2_pokemonspeciesnames: [Pokemon_v2_pokemonspeciesname] { __data["pokemon_v2_pokemonspeciesnames"] }

      /// PokemonSpecy.Pokemon_v2_pokemonspeciesname
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
}
