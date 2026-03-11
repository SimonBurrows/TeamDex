//
//  Sprite.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import Foundation

protocol Sprite: Sendable {
    var imageUrl: URL? { get }
    var id: String { get }
}


// TODO remove pokemon specific stuff from here
public struct PokeballSprite: Sprite {
    var id: String
    
    public var imageUrl: URL? {
        URL(string: String(format: Self.urlTemplate, id))
    }
}


extension PokeballSprite {
    static let urlTemplate = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/%@.png"
    
    public static let data: [PokeballSprite] = [
        .init(id: "master-ball"),
        .init(id: "poke-ball"),
        .init(id: "great-ball"),
        .init(id: "ultra-ball"),
        .init(id: "premier-ball"),
        
    ]
}
