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
    
    private let tileGenerator: TileGenerator
    
    init(tileGenerator: TileGenerator = RandomTileGenerator()) {
        self.tileGenerator = tileGenerator
        populateBoard()
        assignNumberOfSurroundingBeesToTiles()
    }
    
    subscript(row: Int, col: Int) -> Tile? {
        tileAt(row: row, col: col)
    }
    
    func tileAt(row: Int, col: Int) -> Tile? {
        //TODO: board is currently hardcoded to have 8 rows/columns, change this later on
        if row < 0 || row >= 8 {
            return nil
        }
        if col < 0 || col >= 8 {
            return nil
        }

        let index = (row * 8) + col
        return tiles[index]
    }
    
    private func assignNumberOfSurroundingBeesToTiles() {
        for tile in tiles where tile.value.isHoney {
            tile.value = .honey(beesAround(tile: tile))
        }
    }
    
    private func beesAround(tile: Tile) -> Int {
        let finalBees: [Tile?] = [
            aboveLeft(tile: tile),
            left(tile: tile),
            belowLeft(tile: tile),
            above(tile: tile),
            aboveRight(tile: tile),
            belowRight(tile: tile),
            right(tile: tile),
            below(tile: tile)
        ]
        
        let nonNilTiles = finalBees.compactMap { $0 }
        let finalNumBeesAround = nonNilTiles
                                     .filter { $0.value.isBee }
                                     .count
        return finalNumBeesAround
    }
    
    func revealAllZeroesAround(tile: Tile) {
        switch tile.value {
        case .bee:
            break
        case .honey:
            if tile.isRevealed {
                return
            }
            self[tile.row, tile.col]?.isRevealed = true
            if tile.value.isZero {
                openTilesAround(tile: tile)
            }
        }
    }
    
    private func openTilesAround(tile: Tile) {
        if let tileAbove = above(tile: tile), !tileAbove.isRevealed {
            revealAllZeroesAround(tile: tileAbove)
        }
        if let tileAboveRight = aboveRight(tile: tile), !tileAboveRight.isRevealed {
            revealAllZeroesAround(tile: tileAboveRight)
        }
        if let tileAboveLeft = aboveLeft(tile: tile), !tileAboveLeft.isRevealed {
            revealAllZeroesAround(tile: tileAboveLeft)
        }
        if let tileBelow = below(tile: tile), !tileBelow.isRevealed {
            revealAllZeroesAround(tile: tileBelow)
        }
        if let tileBelowRight = belowRight(tile: tile), !tileBelowRight.isRevealed {
            revealAllZeroesAround(tile: tileBelowRight)
        }
        if let tileBelowLeft = belowLeft(tile: tile), !tileBelowLeft.isRevealed {
            revealAllZeroesAround(tile: tileBelowLeft)
        }
        if let tileRight = right(tile: tile), !tileRight.isRevealed {
            revealAllZeroesAround(tile: tileRight)
        }
        if let tileLeft = left(tile: tile), !tileLeft.isRevealed {
            revealAllZeroesAround(tile: tileLeft)
        }
    }
    
    func aboveLeft(tile: Tile) -> Tile? {
        self[tile.row - 1, tile.col - 1]
    }
    
    func belowLeft(tile: Tile) -> Tile? {
        self[tile.row + 1, tile.col - 1]
    }
    
    func left(tile: Tile) -> Tile? {
        self[tile.row, tile.col - 1]
    }
    
    func aboveRight(tile: Tile) -> Tile? {
        self[tile.row - 1, tile.col + 1]
    }
    
    func belowRight(tile: Tile) -> Tile? {
        self[tile.row + 1, tile.col + 1]
    }
    
    func right(tile: Tile) -> Tile? {
        self[tile.row, tile.col + 1]
    }
    
    func above(tile: Tile) -> Tile? {
        self[tile.row - 1, tile.col]
    }
    
    func below(tile: Tile) -> Tile? {
        self[tile.row + 1, tile.col]
    }

    private func populateBoard() {
        let randomTiles = tileGenerator.generateTiles()
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
        if tile.value.isBee {
            tile.isRevealed = true
            gameState = .lost
            return
        }
        
        if tile.value.isZero {
            // Reveal all the other tiles with no bees around it
            revealAllZeroesAround(tile: tile)
            return
        }
        
        tile.isRevealed = true
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
