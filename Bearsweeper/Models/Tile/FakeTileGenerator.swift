//
//  FakeTileGenerator.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-21.
//

import Foundation

struct FakeTileGenerator: TileGenerator {
    func generateTiles() -> Set<Int> {
        [1, 2, 3, 5, 8, 13, 21, 34, 55, 61]
    }
}
