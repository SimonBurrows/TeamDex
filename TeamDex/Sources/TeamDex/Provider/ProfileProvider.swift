//
//  ProfileProvider.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

public protocol ProfileProviderProtocol: Sendable {
    func defaultProfile() -> Profile
    func profile(fromSeed seed: String) -> Profile
    func profile(withId profileId: String) -> Result<Profile, FetchError>
    func allProfiles() -> [Profile]
}
