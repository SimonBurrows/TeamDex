//
//  Game.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

// TODO extract to model
struct Game: Codable {
    let name: String
    let players: [String]
    let profileIds: [String]
    let senarios: [Senario]
    let sprites: [String]?
    let profileResolver: ProfileResolver
    
    init(name: String, players: [String], profileIds: [String], senarios: [Senario], sprites: [String]? = nil, profileResolver: ProfileResolver) {
        self.name = name
        self.players = players
        self.profileIds = profileIds
        self.senarios = senarios
        self.sprites = sprites
        self.profileResolver = profileResolver
    }
}
