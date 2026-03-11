//
//  GameView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

struct GamePlayView: View {
    let profileFetcher: ProfileFetcherProtocol
    let player: String
    let profileId: String
    let senarios: [Senario]
    
    var body: some View {
        VStack {
            VStack {
                TabView {
                    ProfileLoaderView(profileFetcher: profileFetcher, profileId: profileId)
                    ForEach(senarios, id: \.self.title) { scenario in
                        SenarioView(senario: scenario)
                    }
                }
                .tabViewStyle(.page)
            }
            
        }
    }
    
}
