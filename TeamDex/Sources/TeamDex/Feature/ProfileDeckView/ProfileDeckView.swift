//
//  ProfileDeckView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

public struct ProfileDeckView: View {
    let profileProvider: ProfileProviderProtocol
    
    public var body: some View {
        VStack {
                
            VStack {
                TabView {
                    ForEach(profileProvider.allProfiles(), id: \.self.name) { profile in
                        ProfileView(profile: profile)
                    }
                }
                .tabViewStyle(.page)
            }
            
        }.detailBackground()
    }
    
    public init(profileProvider: ProfileProviderProtocol) {
        self.profileProvider = profileProvider
    }
}

#Preview {
    ProfileDeckView(profileProvider: PersonaProvider())
}
