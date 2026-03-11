//
//  PersonaSpriteLabelView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//
import SwiftUI

struct ProfileSpriteLabelView: View  {
    let text: String
    let profile: Profile
    
    public var body: some View {
        SpriteLabelView(text: text, spriteUrl: profile.artworkUrl)
    }
}

// TODO remove pokemon reference from here
struct PokeballLabelView: View {
    let labelText: String
    
    var body: some View {
        SpriteLabelView(text: labelText, spriteUrl: PokeballSprite.data.item(fromSeed: labelText).imageUrl)
    }
}

#Preview {
    PokeballLabelView(labelText: "example@example.com")
}
