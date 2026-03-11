//
//  MenuListView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//
import SwiftUI


public struct MenuListView: View {
    @State private var searchText = ""
    let profileFetcher: ProfileFetcherProtocol
    let players: [String]
    let senarios: [Senario]
    let profileIds: [String]
    
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
                    // TODO fix hardcoded
                    ProfileLoaderDeckView(profileIds: profileIds, profileFetcher: profileFetcher)
                } label: {
                    // TODO sort sprite
//                    SpriteLabelView(text: "All characters", spriteUrl: nil)
//                        spriteUrl: profileProvider.defaultProfile().artworkUrl
                    PokeballLabelView(labelText: "All characters")
                }
                NavigationLink {
                    SenarioDeckView(senarios: senarios)
                } label: {
                    // TODO sort default
//                    SpriteLabelView(text: "All senarios", spriteUrl: nil)
                    PokeballLabelView(labelText: "All senarios")
                }
                
                Section {
                    ForEach(filteredItems, id: \.self) { player in
                        // TODO sort sprite
//                        let profile = profileProvider.profile(fromSeed: item)
                        NavigationLink {
                            ProfileLoaderView(profileFetcher: profileFetcher, profileId: profileIds.item(fromSeed: player)).detailBackground()
                        } label: {
                            // TODO sort sprites
//                            SpriteLabelView(text: player, spriteUrl: nil)
                            PokeballLabelView(labelText: player)
                        }
                    }
                }
            }.navigationTitle("TeamDex")
                .searchable(text: $searchText, prompt: "Search name")
        }
    }
    
    public init(players: [String], profileResolver: ProfileResolver, profileIds: [String], senarios: [Senario]) {
        self.players = players
        self.senarios = senarios
        profileFetcher = ProfileFetcher(profileResolver: profileResolver)
        self.profileIds = profileIds
    }
}
