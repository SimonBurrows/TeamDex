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
    let items: [String]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            items
        } else {
            items.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    public var body: some View {
        NavigationStack {
            List {
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
            }.navigationTitle("TeamDex")
                .searchable(text: $searchText, prompt: "Search name")
        }
    }
    
    public init(items: [String], profileProvider: ProfileProviderProtocol) {
        self.items = items
        self.profileProvider = profileProvider
    }
}

#Preview {
    MenuListView(items:  [
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
