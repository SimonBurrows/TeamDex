//
//  Profile.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//

import Foundation

public protocol Profile: Sendable {
    var name: String { get }
    var artworkUrl: URL? { get }
    var bio: String { get }
}
