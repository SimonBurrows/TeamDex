//
//  SenarioView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

struct SenarioView: View {
    let senario: Senario
    let artworkUrl: URL?

    var body: some View {
        ZStack {
            VStack(spacing: 18) {
                // Title
                Text(senario.title)
                    .font(PackageFont.ketchum.font(size: 36))
                    .foregroundStyle(.black)
                    .padding(.top, 16)

                Spacer()
                if let artworkUrl {
                    AsyncImage(url: artworkUrl) { image in
                        image
                            .resizable()
                            .interpolation(.none)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 260)
                            .shadow(radius: 4, y: 3)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 260)
                    }
                }
                Spacer()

                // Dialogue box
                DialogBox(text: senario.text)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
            }
        }
    }
    
    init(senario: Senario, artworkUrl: URL? = nil) {
        self.senario = senario
        self.artworkUrl = artworkUrl
    }
}

#Preview {
    SenarioView(senario: Senario(
        title: "Something happened!", text: "You encountered an interesting thing while you were doing a thing")
    )
}

