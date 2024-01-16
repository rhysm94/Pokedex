// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAllAbilitiesQuery: GraphQLQuery {
  public static let operationName: String = "GetAllAbilities"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAllAbilities { pokemon_v2_ability( order_by: { name: asc } where: { is_main_series: { _eq: true } } ) { __typename id name pokemon_v2_abilitynames( where: { pokemon_v2_language: { iso639: { _eq: "en" } } } ) { __typename name } } }"#
    ))

  public init() {}

  public struct Data: PokedexAPILive.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Query_root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon_v2_ability", [Pokemon_v2_ability].self, arguments: [
        "order_by": ["name": "asc"],
        "where": ["is_main_series": ["_eq": true]]
      ]),
    ] }

    /// fetch data from the table: "pokemon_v2_ability"
    public var pokemon_v2_ability: [Pokemon_v2_ability] { __data["pokemon_v2_ability"] }

    /// Pokemon_v2_ability
    ///
    /// Parent Type: `Pokemon_v2_ability`
    public struct Pokemon_v2_ability: PokedexAPILive.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_ability }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("name", String.self),
        .field("pokemon_v2_abilitynames", [Pokemon_v2_abilityname].self, arguments: ["where": ["pokemon_v2_language": ["iso639": ["_eq": "en"]]]]),
      ] }

      public var id: Int { __data["id"] }
      public var name: String { __data["name"] }
      /// An array relationship
      public var pokemon_v2_abilitynames: [Pokemon_v2_abilityname] { __data["pokemon_v2_abilitynames"] }

      /// Pokemon_v2_ability.Pokemon_v2_abilityname
      ///
      /// Parent Type: `Pokemon_v2_abilityname`
      public struct Pokemon_v2_abilityname: PokedexAPILive.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PokedexAPILive.Objects.Pokemon_v2_abilityname }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
        ] }

        public var name: String { __data["name"] }
      }
    }
  }
}
