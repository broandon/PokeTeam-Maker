//
//  kantoResponseModel.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let kantoPokedex = try? newJSONDecoder().decode(KantoPokedex.self, from: jsonData)

// MARK: - KantoPokedex
public class KantoPokedex: Codable {
    public let descriptions: [Description]?
    public let id: Int?
    public let isMainSeries: Bool?
    public let name: String?
    public let names: [Name]?
    public let pokemonEntries: [PokemonEntry]?
    public let region: Region?
    public let versionGroups: [Region]?

    enum CodingKeys: String, CodingKey {
        case descriptions, id
        case isMainSeries = "is_main_series"
        case name, names
        case pokemonEntries = "pokemon_entries"
        case region
        case versionGroups = "version_groups"
    }

    public init(descriptions: [Description]?, id: Int?, isMainSeries: Bool?, name: String?, names: [Name]?, pokemonEntries: [PokemonEntry]?, region: Region?, versionGroups: [Region]?) {
        self.descriptions = descriptions
        self.id = id
        self.isMainSeries = isMainSeries
        self.name = name
        self.names = names
        self.pokemonEntries = pokemonEntries
        self.region = region
        self.versionGroups = versionGroups
    }
}

// MARK: - Description
public class Description: Codable {
    public let descriptionDescription: String?
    public let language: Region?

    enum CodingKeys: String, CodingKey {
        case descriptionDescription = "description"
        case language
    }

    public init(descriptionDescription: String?, language: Region?) {
        self.descriptionDescription = descriptionDescription
        self.language = language
    }
}

// MARK: - Region
public class Region: Codable {
    public let name: String?
    public let url: String?

    public init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

// MARK: - Name
public class Name: Codable {
    public let language: Region?
    public let name: String?

    public init(language: Region?, name: String?) {
        self.language = language
        self.name = name
    }
}

// MARK: - PokemonEntry
public class PokemonEntry: Codable {
    public let entryNumber: Int?
    public let pokemonSpecies: Region?

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }

    public init(entryNumber: Int?, pokemonSpecies: Region?) {
        self.entryNumber = entryNumber
        self.pokemonSpecies = pokemonSpecies
    }
}
