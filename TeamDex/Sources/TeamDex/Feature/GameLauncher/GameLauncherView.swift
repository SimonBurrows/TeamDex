//
//  GameLauncherView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

public struct GameLauncherView: View {
    let exampleGames: [Game]
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(Self.exampleGames, id: \.self.name) { game in
                    NavigationLink {
                        MenuListView(
                            players: game.players,
                            profileResolver: game.profileResolver,
                            profileIds: game.profileIds,
                            senarios: game.senarios,
                            sprites: game.sprites
                        )
                    } label: {
                        Text(game.name)
                    }
                }
                    
            }
        }.navigationTitle("Select Game")
    }


    // TODO get this out of view
    public init() {
        do {
            let data = Data(Self.exampleGameJson.utf8)
            exampleGames = try JSONDecoder().decode([Game].self, from: data)
        } catch {
            print("Failed to decode games:", error)
            exampleGames = []
        }         
    }
}

#Preview {
    GameLauncherView()
}
