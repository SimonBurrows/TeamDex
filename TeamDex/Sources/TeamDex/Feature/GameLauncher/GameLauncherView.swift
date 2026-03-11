//
//  GameLauncherView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

public struct GameLauncherView: View {
    let data: Data
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(exampleGames, id: \.self.name) { game in
                    NavigationLink {
                        MenuListView(
                            players: game.players,
                            profileResolver: game.profileResolver,
                            profileIds: game.profileIds,
                            senarios: game.senarios
                        )
                    } label: {
                        Text(game.name)
                    }
                }
                    
            }
        }.navigationTitle("Select Game")
    }


    
    public init() {
        do {
            data = try JSONEncoder().encode(PersonaProvider.data)
        } catch {
            data = Data()
        }
         
    }
    
    // TOD oget rid
    
    let exampleGames: [Game] = [
        Game(
name: "Something ace",
             players:  [
                "Simon",
                "Kevin",
                "Gabby",
                "Paul",
                "Carl",
                "Nick"
             ],
             profileIds: (1...150).map(String.init),
             senarios: [
                Senario(
                    title: "Treasure hunt",
                    text: "Find sombody of the same type as you"
                )
             ],
             profileResolver: ProfileResolver(
                name: .init(
                    source: 
                            .api(
                                urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@"
                            ),
                    path: "name"
                ),
                bio: .init(
                    source: 
                            .api(
                                urlTemplate: "https://pokeapi.co/api/v2/pokemon-species/%@"
                            ),
                    path: "flavor_text_entries.0.flavor_text"
                ),
                artworkUrl: .init(
                    source: 
                            .api(
                                urlTemplate: "https://pokeapi.co/api/v2/pokemon/%@"
                            ),
                    path: "sprites.other.official-artwork.front_default"
                )
             )
        ),
        
        
        
        
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
            profileIds: ["misty", "ash"],
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
            profileResolver: ProfileResolver(
                name: .init(
                    source: .local(data: personaJson),
                    path: "name"
                ),
                bio: .init(
                    source: .local(data: personaJson),
                    path: "bio"
                ),
                artworkUrl: .init(
                    source: .local(data: personaJson),
                    path: "artworkUrl"
                )
            ),
        )
    ]
}

#Preview {
    GameLauncherView()
}

extension GameLauncherView {
    static let personaJson = """
    [
      {
        "name": "Ash",
        "artworkUrl": "https://play.pokemonshowdown.com/sprites/trainers/ash.png",
        "bio": "I'm a mobile app software engineer..."
      },
      {
        "name": "Misty",
        "artworkUrl": "https://play.pokemonshowdown.com/sprites/trainers/misty.png",
        "bio": "I'm a backend engineer..."
      }
    ]
    """.data(using: .utf8)!
}
