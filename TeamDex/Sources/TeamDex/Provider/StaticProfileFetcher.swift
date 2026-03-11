//
//  StaticProfileFetcher.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

struct StaticProfileFetcher: ProfileFetcherProtocol {
    let profileProvider: ProfileProviderProtocol
    
    func fetchProfile(withId profileId: String) async -> Result<Profile, FetchError> {
        profileProvider.profile(withId: profileId)
    }
}
