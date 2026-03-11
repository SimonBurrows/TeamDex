//
//  PersonaProvider.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//

import Foundation

// TODO get rid
public struct PersonaProvider: ProfileProviderProtocol {
    public func defaultProfile() -> any Profile {
        Self.data.item(fromSeed: "default")
    }
    
    public func profile(withId profileId: String) -> Result<Profile, FetchError> {
        guard let profile = Self.data.first(where: { $0.name == profileId }) else {
            return .failure(.unknown)
        }
        
        return .success(profile)
    }
    
    public func profile(fromSeed seed: String) -> Profile {
        Self.data.item(fromSeed: seed)
    }
    
    public func allProfiles() -> [Profile] {
        Self.data
    }
    
    public init() {}
}



extension PersonaProvider {
    static let data = [
        DynamicProfile(
            name: "Ash",
            artworkUrl: URL(
                string: "https://play.pokemonshowdown.com/sprites/trainers/ash.png"
            ),
            bio: "I'm a mobile app software engineer trying to release a new app for the first time. Let's GO!"
        ),
        DynamicProfile(
            name: "Misty",
            artworkUrl: URL(
                string: "https://play.pokemonshowdown.com/sprites/trainers/misty.png"
            ),
            bio: "I'm a backend engineer writing shared BFF modules for mobile experience teams. I need to know about the data spec for analytics used by the apps and their backends."
        ),
        DynamicProfile(
            name: "Kev",
            artworkUrl: URL(
                string: "https://play.pokemonshowdown.com/sprites/trainers/bugcatcher-gen3rs.png"
            ),
            bio: "I'm a tester trying to understand when a bug was introduced, and how many users are affected."
        ),
        DynamicProfile(
            name: "Brock",
            artworkUrl: URL(
                string: "https://play.pokemonshowdown.com/sprites/trainers/ash.png"
            ),
            bio: "I'm a UX designer with some coding skills. I want to send prototype apps around the business quickly."
        )
    ]
}
