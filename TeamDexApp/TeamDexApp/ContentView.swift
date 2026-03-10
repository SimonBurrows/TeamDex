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
            SpriteLabelView(text: "Simon", spriteUrl: URL(string: "https://play.pokemonshowdown.com/sprites/trainers/ash.png"))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
