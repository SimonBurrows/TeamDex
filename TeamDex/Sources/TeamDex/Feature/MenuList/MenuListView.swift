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
    let senarios: [Senario]
    
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
                NavigationLink {
                    SenarioDeckView(senarios: senarios)
                } label: {
                    SpriteLabelView(text: "All senarios", spriteUrl: profileProvider.profile(fromSeed: "All senarios").artworkUrl)
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
    
    public init(players: [String], profileProvider: ProfileProviderProtocol, senarios: [Senario]) {
        self.players = players
        self.profileProvider = profileProvider
        self.senarios = senarios
    }
}

#Preview {
    MenuListView(
        players:  [
            "Simon",
            "Kevin",
            "Gabby",
            "Paul",
            "Carl",
            "Nick"
        ],
        profileProvider: PersonaProvider(),
        senarios: [
            Senario(title: "Wow!", text: "This is a senario")
        ]
    )
}
