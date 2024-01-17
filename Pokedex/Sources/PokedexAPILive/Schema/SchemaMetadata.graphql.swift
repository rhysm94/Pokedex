// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == PokedexAPILive.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == PokedexAPILive.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == PokedexAPILive.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == PokedexAPILive.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "query_root": return PokedexAPILive.Objects.Query_root
    case "pokemon_v2_ability": return PokedexAPILive.Objects.Pokemon_v2_ability
    case "pokemon_v2_abilityname": return PokedexAPILive.Objects.Pokemon_v2_abilityname
    case "pokemon_v2_abilityflavortext": return PokedexAPILive.Objects.Pokemon_v2_abilityflavortext
    case "pokemon_v2_pokemonability": return PokedexAPILive.Objects.Pokemon_v2_pokemonability
    case "pokemon_v2_pokemon": return PokedexAPILive.Objects.Pokemon_v2_pokemon
    case "pokemon_v2_pokemonspecies": return PokedexAPILive.Objects.Pokemon_v2_pokemonspecies
    case "pokemon_v2_pokemonspeciesname": return PokedexAPILive.Objects.Pokemon_v2_pokemonspeciesname
    case "pokemon_v2_evolutionchain": return PokedexAPILive.Objects.Pokemon_v2_evolutionchain
    case "pokemon_v2_pokemontype": return PokedexAPILive.Objects.Pokemon_v2_pokemontype
    case "pokemon_v2_type": return PokedexAPILive.Objects.Pokemon_v2_type
    case "pokemon_v2_typename": return PokedexAPILive.Objects.Pokemon_v2_typename
    case "pokemon_v2_pokemonmove": return PokedexAPILive.Objects.Pokemon_v2_pokemonmove
    case "pokemon_v2_versiongroup": return PokedexAPILive.Objects.Pokemon_v2_versiongroup
    case "pokemon_v2_move": return PokedexAPILive.Objects.Pokemon_v2_move
    case "pokemon_v2_movename": return PokedexAPILive.Objects.Pokemon_v2_movename
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
