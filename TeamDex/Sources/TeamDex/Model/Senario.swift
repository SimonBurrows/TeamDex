//
//  Senario.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

public struct Senario: Equatable {
    let title: String
    let text: String
    let spriteUrl: String?
    
    public init(title: String, text: String, spriteUrl: String? = nil) {
        self.title = title
        self.text = text
        self.spriteUrl = spriteUrl
    }
}
