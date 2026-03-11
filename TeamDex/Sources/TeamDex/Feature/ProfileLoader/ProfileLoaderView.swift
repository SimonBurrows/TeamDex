//
//  ProfileLoader.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

struct ProfileLoaderView: View {
    let ProfileFetcher: ProfileFetcherProtocol
    let profileId: String
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack {
                
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .ready(let profile):
                    ProfileView(profile: profile)
                case .failed:
                    Text("Error")
                }
                
            }
        }
        
        .task {
            await viewModel.loadData(withId: profileId)
        }
    }
    
    init(profileFetcher: ProfileFetcherProtocol, profileId: String) {
        self.profileId = profileId
        self.ProfileFetcher = profileFetcher
        _viewModel = StateObject(
            wrappedValue: ViewModel(profileFetcher: profileFetcher)
        )
    }
}

extension ProfileLoaderView {
    
    enum ProfileViewState {
        case loading
        case ready(profile: Profile)
        case failed
    }
}

#Preview {
    let profileResolver = ProfileResolver(
        name: .init(
            source: .api(urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@"),
            path: "name"
        ),
        bio: .init(
            source: .api(urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@"),
            path: "flavor_text_entries.0.flavor_text"
        ),
        artworkUrl: .init(
            source: .api(urlTemplate: "https://pokeapi.co/api/v2/pokemon/%@"),
            path: "sprites.other.official-artwork.front_default"
        )
    )

    
    
    ProfileLoaderView(
        profileFetcher: ProfileFetcher(profileResolver: profileResolver),
        profileId: "3"
    )
}
