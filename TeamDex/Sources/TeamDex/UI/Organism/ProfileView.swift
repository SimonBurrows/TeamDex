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

#Preview {
    ProfileView(profile: Persona(
        artworkId: "misty",
        name: "Misty",
        bio: "I'm a backend engineer writing shared BFF modules for mobile experience teams. I need to know about the data spec for analytics used by the apps and their backends."
    ))
}

