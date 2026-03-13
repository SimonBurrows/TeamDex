//
//  MenuListView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//
import SwiftUI


public struct MenuListView: View {
    @State private var searchText = ""
    let gameName: String
    let profileFetcher: ProfileFetcherProtocol
    let players: [String]
    let senarios: [Senario]
    let profileIds: [String]
    let sprites: [String]?
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            players
        } else {
            players.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    public var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ProfileLoaderDeckView(profileIds: profileIds, profileFetcher: profileFetcher)
                } label: {
                    let text = "All characters"
                    SpriteLabelView(text: text, spriteUrlString: sprites?.item(fromSeed: text))

                }
                NavigationLink {
                    SenarioDeckView(senarios: senarios)
                } label: {
                    let text = "All scenarios"
                    SpriteLabelView(text: text, spriteUrlString: sprites?.item(fromSeed: text))

                }
                
                Section {
                    ForEach(filteredItems, id: \.self) { player in
                        NavigationLink {
                            GamePlayView(
                                profileFetcher: profileFetcher, player: player,
                                profileId: profileIds.item(fromSeed: player),
                                senarios: senarios
                            )
                                .detailBackground()
                        } label: {
                            SpriteLabelView(text: player, spriteUrlString: sprites?.item(fromSeed: player))
                        }
                    }
                }
            }.navigationTitle(gameName)
                .searchable(text: $searchText, prompt: "Search name")
        }
    }
    
    public init(gameName: String, players: [String], profileResolver: ProfileResolver, profileIds: [String], senarios: [Senario], sprites: [String]? = nil) {
        self.gameName = gameName
        self.players = players
        self.senarios = senarios
        profileFetcher = ProfileFetcher(profileResolver: profileResolver)
        self.profileIds = profileIds
        self.sprites = sprites
    }
}
