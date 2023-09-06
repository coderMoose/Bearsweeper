//
//  TileGenerator.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-21.
//

import Foundation

protocol TileGenerator {
    func generateTiles(gameType: GameType) -> Set<Int>
}

struct RandomTileGenerator: TileGenerator {
    func generateTiles(gameType: GameType) -> Set<Int> {
        var randomTiles: Set<Int> = []
        
        while randomTiles.count != gameType.numBees {
            let randomPos = Int.random(in: 0..<gameType.numTiles)
            randomTiles.insert(randomPos)
        }
        
        return randomTiles
    }
}

