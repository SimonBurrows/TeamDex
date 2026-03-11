//
//  SenarioView.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI

struct SenarioView: View {
    let senario: Senario

    var body: some View {
        ZStack {
            VStack(spacing: 18) {
                // Title
                Text(senario.title)
                    .font(PackageFont.ketchum.font(size: 36))
                    .foregroundStyle(.black)
                    .padding(.top, 16)

                Spacer()

                // Dialogue box
                DialogBox(text: senario.text)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    SenarioView(senario: Senario(
        title: "Something happened!", text: "You encountered an interesting thing while you were doing a thing")
    )
}

