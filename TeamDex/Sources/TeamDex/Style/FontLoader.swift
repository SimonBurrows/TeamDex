//
//  FontLoader.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

import SwiftUI
import CoreText

enum FontLoader {
    static func registerFont(_ font: PackageFont) {
        guard let url = Bundle.module.url(forResource: font.rawValue, withExtension: "ttf") else {
            return
        }

        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
}
