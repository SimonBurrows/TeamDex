//
//  MenuListView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//
import SwiftUI


public struct MenuListView: View {
    @State private var searchText = ""
    
    let profileProvider: ProfileProviderProtocol
    let players: [String]
    
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
                    ProfileDeckView(profileProvider: profileProvider)
                } label: {
                    SpriteLabelView(text: "All characters", spriteUrl: profileProvider.defaultProfile().artworkUrl)
                }
                
                Section {
                    ForEach(filteredItems, id: \.self) { item in
                        let profile = profileProvider.profile(fromSeed: item)
                        NavigationLink {
                            ProfileView(profile: profile).detailBackground()
                        } label: {
                            ProfileSpriteLabelView(
                                text: item,
                                profile: profile
                            )
                        }
                    }
                }
            }.navigationTitle("TeamDex")
                .searchable(text: $searchText, prompt: "Search name")
        }
    }
    
    public init(players: [String], profileProvider: ProfileProviderProtocol) {
        self.players = players
        self.profileProvider = profileProvider
    }
}

#Preview {
    MenuListView(players:  [
        "Simon",
        "Kevin",
        "Gabby",
        "Paul",
        "Carl",
        "Nick"
    ],
    profileProvider: PersonaProvider()
    )
}
