//
//  ProfileFetcherProtocol.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

public protocol ProfileFetcherProtocol: Sendable {
    func fetchProfile(withId profileId: String) async -> Result<Profile, FetchError>
}
