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
                }.tabViewStyle(.page).detailBackground()
            }
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
