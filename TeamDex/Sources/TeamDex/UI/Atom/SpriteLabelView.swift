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
    
    public init(text: String, spriteUrlString: String? = nil) {
        self.text = text
        if let spriteUrlString = spriteUrlString {
            self.spriteUrl = URL(string: spriteUrlString)
        } else {
            self.spriteUrl = URL(string: Self.defaultSprites.item(fromSeed: text))
        }
    }
}

extension SpriteLabelView {
    static let defaultSprites: [String] = [
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/master-ball.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/great-ball.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/ultra-ball.png",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/premier-ball.png"

    ]
    
    static let defaultSpriteUrl: URL? = URL(string: "https://play.pokemonshowdown.com/sprites/trainers/ash.png")
}

#Preview {
    SpriteLabelView(
        text: "Some lovely text"
    )
}
