//
//  Persona.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//

import Foundation

public struct Persona: Codable, Profile, Hashable {
    public var artworkId: String
    
    public var name: String
    
    public var artworkUrl: URL? {
        URL(string: String(format: Self.imageUrlTemplate, artworkId))
    }
    
    public var bio: String
    
    public init(artworkId: String, name: String, bio: String) {
        self.artworkId = artworkId
        self.name = name
        self.bio = bio
    }
    
    private static let imageUrlTemplate = "https://play.pokemonshowdown.com/sprites/trainers/%@.png"
}
