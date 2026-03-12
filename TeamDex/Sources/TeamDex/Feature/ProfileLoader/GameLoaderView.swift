//
//  GameLoaderView.swift
//  TeamDex
//
//  Created by Simon Burrows on 12/03/2026.
//

import SwiftUI

// Same as profile loader but it loads the scenarios too
struct GameLoaderView: View {
    let ProfileFetcher: ProfileFetcherProtocol
    let profileId: String
    let senarios: [Senario]
    
    @StateObject private var viewModel: ProfileLoaderView.ViewModel
    
    var body: some View {
        VStack {
            VStack {
                
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .ready(let profile):
                    TabView {
                        ProfileView(profile: profile)
                        
                        ForEach(senarios, id: \.self.title) { senario in
                            SenarioView(senario: senario, artworkUrl: profile.artworkUrl)
                        }
                    }
                    .tabViewStyle(.page)
                case .failed:
                    Text("Error")
                }
                
            }
        }
        
        .task {
            await viewModel.loadData(withId: profileId)
        }
    }
    
    init(profileFetcher: ProfileFetcherProtocol, profileId: String, senarios: [Senario]) {
        self.profileId = profileId
        self.ProfileFetcher = profileFetcher
        self.senarios = senarios
        _viewModel = StateObject(
            wrappedValue: ProfileLoaderView.ViewModel(profileFetcher: profileFetcher)
        )
    }
}
