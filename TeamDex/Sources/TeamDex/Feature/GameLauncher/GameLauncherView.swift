//
//  GameLauncherView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

public struct GameLauncherView: View {
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(exampleGames, id: \.self.name) { game in
                    NavigationLink {
                        MenuListView(
                            players: game.players,
                            profileProvider: game.profileProvider, senarios: game.senarios
                        )
                    } label: {
                        Text(game.name)
                    }
                }
                    
            }
        }.navigationTitle("Select Game")
    }


    public init() {}
    
    let exampleGames: [Game] = [
        Game(
            name: "Fun game",
            players:  [
                "Simon",
                "Kevin",
                "Gabby",
                "Paul",
                "Carl",
                "Nick"
            ],
            senarios: [
                Senario(
                    title: "Sharing what we do",
                    text: "How do we share what we are doing with this user type?"
                ),
                Senario(
                    title: "Hypothesis statement",
                    text: "Can we tun these into a set of hypothesis statements? \nHypothesis statement\nExample: We believe that sharing our roadmap early and often will reduce duplicate efforts and requests from other teams. We will know this is true when duplicate work-streams reduce."
                )
            ],
            profileProvider: PersonaProvider()
        )
    ]
}

#Preview {
    GameLauncherView()
}
