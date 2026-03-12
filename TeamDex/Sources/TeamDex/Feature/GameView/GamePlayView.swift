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
                    GameLoaderView(profileFetcher: profileFetcher, profileId: profileId, senarios: senarios)
                }
                .tabViewStyle(.page)
            }
            
        }
    }
    
}
