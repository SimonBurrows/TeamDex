//
//  ProfileDeckView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

public struct SenarioDeckView: View {
    let senarios: [Senario]
    
    public var body: some View {
        VStack {
                
            VStack {
                TabView {
                    ForEach(senarios, id: \.self.title) { senario in
                        SenarioView(senario: senario)
                    }
                }
                .tabViewStyle(.page)
            }
            
        }.detailBackground()
    }
    
    public init(senarios: [Senario]) {
        self.senarios = senarios
    }
}

#Preview {
    ProfileDeckView(profileProvider: PersonaProvider())
}
