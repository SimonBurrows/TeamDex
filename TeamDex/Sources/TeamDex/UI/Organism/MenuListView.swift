//
//  MenuListView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//
import SwiftUI


public struct MenuListView: View {
    @State private var searchText = ""
    
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
                    NavigationLink {
                        ProfileView(profile: PersonaProvider().persona(fromSeed: item)).detailBackground()
                    } label: {
                        PersonaSpriteLabelView(
                            text: item
                        )
                    }
                }
            }.navigationTitle("TeamDex")
                .searchable(text: $searchText, prompt: "Search name")
        }
    }
    
    public init(items: [String]) {
        self.items = items
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
    ])
}
