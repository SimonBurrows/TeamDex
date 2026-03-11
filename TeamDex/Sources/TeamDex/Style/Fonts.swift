//
//  Fonts.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//
import SwiftUI

enum PackageFont: String, CaseIterable {
    case ketchum = "ketchum"
    case pokemonClasic = "Pokemon Classic"
    
    func font(size: CGFloat) -> Font {
        FontLoader.registerFont(self)
        return .custom(self.rawValue, size: size)
    }
}
