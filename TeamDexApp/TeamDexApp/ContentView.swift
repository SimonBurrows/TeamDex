//
//  ContentView.swift
//  TeamDexApp
//
//  Created by Simon Burrows on 10/03/2026.
//

import SwiftUI
import TeamDex

struct ContentView: View {
    var body: some View {
        VStack {
            MenuListView(items: [
                "Simon",
                "Kevin",
                "Gabby",
                "Paul",
                "Carl",
                "Nick"
            ])
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
