//
//  ProfileLoaderDeckView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

public struct ProfileLoaderDeckView: View {
    let profileIds: [String]
    let profileFetcher: ProfileFetcherProtocol
    
    public var body: some View {
        VStack {
            
            VStack {
                TabView {
                    ForEach(profileIds, id: \.self) { profileId in
                        ProfileLoaderView(profileFetcher: profileFetcher, profileId: profileId)
                    }
                }.tabViewStyle(.page)
    
            }.detailBackground()
        }
    }
    
    public init(profileIds: [String], profileFetcher: ProfileFetcherProtocol) {
        self.profileIds = profileIds
        self.profileFetcher = profileFetcher
    }
    
    public init(staticProfiles: [Profile], profileFetcher: ProfileFetcherProtocol) {
        self.profileIds = staticProfiles.map { $0.name }
        self.profileFetcher = profileFetcher
    }
}

#Preview {
    let profileIds = (1...150).map(String.init)
    
    let profileResolver = ProfileResolver(
        // TODO tidy urls
        name: .init(
            urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@",
            path: "name"
        ),
        bio: .init(
            urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@",
            path: "flavor_text_entries.0.flavor_text"
        ),
        artworkUrl: .init(
            urlTemplate: "https://pokeapi.co/api/v2/pokemon/%@",
            path: "sprites.other.official-artwork.front_default"
        )
    )
    
    ProfileLoaderDeckView(
        profileIds: profileIds,
        profileFetcher: ProfileFetcher(profileResolver: profileResolver)
    )
}
