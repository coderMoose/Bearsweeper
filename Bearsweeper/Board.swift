//
//  Board.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import Foundation

class Board: ObservableObject {
    @Published var gameState: GameState = .ongoing
    @Published var tiles: [Tile] = []

    init() {
        populateBoard()
    }
    
    subscript(row: Int, col: Int) -> Tile? {
        tileAt(row: row, col: col)
    }
    
    func tileAt(row: Int, col: Int) -> Tile? {
        //TODO: board is currently hardcoded to have 8 rows/columns, change this later on
        let index = (row * 8) + col
        return tiles[index]
    }

    private func populateBoard() {
        let randomTiles = generateTiles()
        tiles.reserveCapacity(64)

        for i in 0..<64 {
            let row = i / 8
            let col = i % 8
            
            let isBeeTile = randomTiles.contains(i)
            let newTile = Tile(value: isBeeTile ? .bee : .honey(0), row: row, col: col)
            tiles.append(newTile)
        }
    }
    
    func processTap(tile: Tile) {
        tile.isRevealed = true
        if tile.value.isBee {
            gameState = .lost
            return
        }
    }
    
    private func generateTiles() -> Set<Int> {
        var randomTiles: Set<Int> = []
        
        //TODO: make this the correct number of mines for different game types instead of 10
        while randomTiles.count != 10 {
            let randomPos = Int.random(in: 0..<64)
            randomTiles.insert(randomPos)
        }
        
        return randomTiles
    }
}
