//
//  FakeTileGenerator.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-21.
//

@testable import Bearsweeper
import Foundation

struct FakeTileGenerator: TileGenerator {
    func generateTiles(gameType: Bearsweeper.GameType) -> Set<Int> {
        [1, 2, 3, 5, 8, 13, 21, 34, 55, 61]
    }
}
