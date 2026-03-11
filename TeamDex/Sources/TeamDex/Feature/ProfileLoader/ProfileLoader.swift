//
//  ProfileLoader.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

struct ProfileLoaderView: View {
    let ProfileFetcher: ProfileFetcherProtocol
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack {
                
                switch viewModel.state {
                case .loading:
                    // TODO tidy
                    Text("Loading")
                case .ready(let profile):
                    ProfileView(profile: profile)
                case .failed:
                    // TODO tidy
                    Text("Error")
                }
                
            }
        }
        
        .task {
            // TODO remove hard coded
            await viewModel.loadData(seed: "Simon")
        }
    }
    
    init(profileFetcher: ProfileFetcherProtocol) {
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
    
    let profileIds = (1...150).map(String.init)
    
    
    ProfileLoaderView(profileFetcher: ProfileFetcher(profileResolver: profileResolver, profileIds: profileIds))
}
