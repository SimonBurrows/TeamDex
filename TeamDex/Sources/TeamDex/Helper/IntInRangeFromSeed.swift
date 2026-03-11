//
//  SeededClosedRange.swift
//  TeamDexShared
//
//  Created by Simon Burrows on 09/03/2026.
//
import Foundation
import GameKit

extension Int {
    static func fromSeed(_ seed: String, in range: ClosedRange<Int>) -> Int {
        let rng = GKARC4RandomSource(seed: Data(seed.utf8))
        return rng.nextInt(upperBound: range.count) + range.lowerBound
    }
}
