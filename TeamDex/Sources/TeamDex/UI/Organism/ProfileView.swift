//
//  ProfileView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//

import SwiftUI

// AI Generated
struct ProfileView: View {
    let profile: Profile

    var body: some View {
        ZStack {
            VStack(spacing: 18) {
                // Title
                Text(profile.name.capitalized)
                // TODO move fonts to theme
                    .font(PackageFont.ketchum.font(size: 36))
                    .foregroundStyle(.black)
                    .padding(.top, 16)

                Spacer()

                // Sprite / image in the middle
                AsyncImage(url: profile.artworkUrl) { image in
                    image
                        .resizable()
                        .interpolation(.none)        // helps pixel art look crisp
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 260)
                        .shadow(radius: 4, y: 3)
                } placeholder: {
                    ProgressView()
                        .frame(height: 260)
                }

                Spacer()

                // Dialogue box
                DialogBox(text: profile.bio)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
            }
        }
    }
}

struct DialogBox: View {
    let text: String

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Outer border (dark)
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(red: 0.40, green: 0.10, blue: 0.16))
                .overlay(
                    // Inner border (cream)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .inset(by: 4)
                        .fill(Color(red: 0.98, green: 0.95, blue: 0.88))
                )
                .shadow(radius: 8, y: 5)

            // Text
            Text(text)
                .font(PackageFont.pokemonClasic.font(size: 12))
                .font(.system(size: 18, weight: .semibold, design: .monospaced)) // “gamey” without custom fonts
                .foregroundStyle(Color.black.opacity(0.9))
                .lineSpacing(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 18)
                .padding(.vertical, 16)

            // Little cursor triangle
            Image(systemName: "triangle.fill")
                .font(.system(size: 10, weight: .bold))
                .rotationEffect(.degrees(180))
                .foregroundStyle(Color.black.opacity(0.75))
                .padding(12)
        }.fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 24)
    }
}

#Preview {
    ProfileView(profile: Persona(
        artworkId: "misty",
        name: "Misty",
        bio: "I'm a backend engineer writing shared BFF modules for mobile experience teams. I need to know about the data spec for analytics used by the apps and their backends."
    ))
}

