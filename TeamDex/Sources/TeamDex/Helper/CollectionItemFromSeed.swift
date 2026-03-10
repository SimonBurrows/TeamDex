//
//  CollectionItemFromSeed.swift
//  TeamDex
//
//  Created by Simon Burrows on 10/03/2026.
//

import GameplayKit

public extension Collection {
    func item(fromSeed seed: String) -> Element {
        let index = GKARC4RandomSource(seed: Data(seed.utf8)).nextInt(upperBound: count)
        return self[self.index(startIndex, offsetBy: index)]
    }
}
