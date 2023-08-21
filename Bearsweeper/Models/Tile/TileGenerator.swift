//
//  TileGenerator.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-21.
//

import Foundation

protocol TileGenerator {
    func generateTiles() -> Set<Int>
}

struct RandomTileGenerator: TileGenerator {
    func generateTiles() -> Set<Int> {
        var randomTiles: Set<Int> = []
        
        while randomTiles.count != 10 {
            let randomPos = Int.random(in: 0..<64)
            randomTiles.insert(randomPos)
        }
        
        return randomTiles
    }
}

