//
//  ProfileLoaderViewModel.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//
import SwiftUI

extension ProfileLoaderView {
    @MainActor class ViewModel: ObservableObject {
        private let profileFetcher: any ProfileFetcherProtocol
        
        @Published var state:ProfileViewState = .loading
        
        init(profileFetcher: any ProfileFetcherProtocol) {
            self.profileFetcher = profileFetcher
        }
        
        
        func loadData(withId profileId: String) async {
            let profileResult = await profileFetcher.fetchProfile(withId: profileId)
            
            switch profileResult {
            case .success(let profile):
                state = .ready(profile: profile)
            default:
                state = .failed
            }
        }
    }
}
