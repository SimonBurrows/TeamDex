//
//  CleanBioText.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

extension String {
    func cleanBioText() -> String {
        return self
            .replacingOccurrences(of: "\\f", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "\\n", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "\\r", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "  ", with: " ") // Remove any resulting double spaces
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
