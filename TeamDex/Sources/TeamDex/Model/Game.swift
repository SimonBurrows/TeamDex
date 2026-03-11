//
//  Game.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

// TODO extract to model
struct Game {
    let name: String
    let players: [String]
    let senarios: [Senario]
    let profileProvider: any ProfileProviderProtocol
}
