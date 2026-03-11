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
            MenuListView(
                players: [
                    "Simon",
                    "Kevin",
                    "Gabby",
                    "Paul",
                    "Carl",
                    "Nick"
                ],
                profileProvider: PersonaProvider(),
                senarios: [
                    Senario(
                        title: "Sharing what we do",
                        text: "How do we share what we are doing with this user type?"
                    ),
                    Senario(
                        title: "Hypothesis statement",
                        text: "Can we tun these into a set of hypothesis statements? \nHypothesis statement\nExample: We believe that sharing our roadmap early and often will reduce duplicate efforts and requests from other teams. We will know this is true when duplicate work-streams reduce."
                    )
                ]
            )
        }
    }
}

#Preview {
    ContentView()
}
