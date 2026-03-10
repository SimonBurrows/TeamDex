//
//  SpriteLabelView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//

import SwiftUI

public struct SpriteLabelView: View {
    let text: String
    let spriteUrl: URL?
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            HStack {
                AsyncImage(url: spriteUrl,
                           content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                },
                           placeholder: {
                    ProgressView()
                        .frame(height: 50)
                })
                Text(text)
                    .font(.headline)
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)

        }
    }
    
    public init(text: String, spriteUrl: URL?) {
        self.text = text
        self.spriteUrl = spriteUrl
    }
}

#Preview {
    SpriteLabelView(
        text: "Some lovely text",
        spriteUrl: URL(string: "https://play.pokemonshowdown.com/sprites/trainers/ash.png")
    )
}
