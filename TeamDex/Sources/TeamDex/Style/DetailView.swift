//
//  DetailView.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//

import SwiftUI

struct DetailBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.96, green: 0.82, blue: 0.90),
                    Color(red: 0.77, green: 0.53, blue: 0.63)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            content
        }
    }
}

public extension View {
    func detailBackground() -> some View {
        modifier(DetailBackground())
    }
}
