//
//  DialogBox.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

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
    DialogBox(text: "You encounered an interesting thing in the office!")
}
