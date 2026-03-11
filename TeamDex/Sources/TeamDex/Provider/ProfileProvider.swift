//
//  ProfileProvider.swift
//  TeamDex
//
//  Created by Simon Burrows on 11/03/2026.
//

public protocol ProfileProviderProtocol {
    func profile(fromSeed seed: String) -> Profile
}
