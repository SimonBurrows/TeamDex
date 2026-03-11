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
