//
//  Board.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import Foundation

class Board: ObservableObject {
    @Published var gameState: GameState = .ongoing
    @Published private(set) var tiles: [Tile] = []
    @Published private(set) var beesLeft: Int
    
    let gameType: GameType
    private var isFirstTap = true
    private let tileGenerator: TileGenerator
    
    init(gameType: GameType, tileGenerator: TileGenerator = RandomTileGenerator()) {
        self.gameType = gameType
        self.tileGenerator = tileGenerator
        self.beesLeft = gameType.numBees
        populateBoard()
        assignNumberOfSurroundingBeesToTiles()
    }
    
    subscript(row: Int, col: Int) -> Tile? {
        tileAt(row: row, col: col)
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
    
    private func openTilesAround(tile: Tile) {
        if let tileAbove = above(tile: tile), !tileAbove.state.isRevealed {
            revealAllZeroesAround(tile: tileAbove)
        }
        if let tileAboveRight = aboveRight(tile: tile), !tileAboveRight.state.isRevealed {
            revealAllZeroesAround(tile: tileAboveRight)
        }
        if let tileAboveLeft = aboveLeft(tile: tile), !tileAboveLeft.state.isRevealed {
            revealAllZeroesAround(tile: tileAboveLeft)
        }
        if let tileBelow = below(tile: tile), !tileBelow.state.isRevealed {
            revealAllZeroesAround(tile: tileBelow)
        }
        if let tileBelowRight = belowRight(tile: tile), !tileBelowRight.state.isRevealed {
            revealAllZeroesAround(tile: tileBelowRight)
        }
        if let tileBelowLeft = belowLeft(tile: tile), !tileBelowLeft.state.isRevealed {
            revealAllZeroesAround(tile: tileBelowLeft)
        }
        if let tileRight = right(tile: tile), !tileRight.state.isRevealed {
            revealAllZeroesAround(tile: tileRight)
        }
        if let tileLeft = left(tile: tile), !tileLeft.state.isRevealed {
            revealAllZeroesAround(tile: tileLeft)
        }
    }
    
    private func populateBoard() {
        let randomTiles = tileGenerator.generateTiles(gameType: gameType)
        tiles.reserveCapacity(gameType.numTiles)
        
        var row = -1
        for i in 0..<gameType.numTiles {
            let col = i % gameType.numColumns
            // If the tile is in the first column, then it's at the beginning of a new row
            if col == 0 {
                row += 1
            }
            
            let isBeeTile = randomTiles.contains(i)
            let newTile = Tile(value: isBeeTile ? .bee : .honey(0), row: row, col: col)
            tiles.append(newTile)
        }
    }
    
    private func checkIsGameWon() {
        // If there are only tiles with bees left, user has won the game
        let revealedCount = tiles.lazy.filter({ $0.state.isRevealed }).count
        gameState = revealedCount == gameType.numSafeTiles ? .won : .ongoing
    }
    
    private func tileAt(row: Int, col: Int) -> Tile? {
        if row < 0 || row >= gameType.numRows {
            return nil
        }
        if col < 0 || col >= gameType.numColumns {
            return nil
        }

        let index = (row * gameType.numColumns) + col
        return tiles[index]
    }
    
    func revealAllZeroesAround(tile: Tile) {
        switch tile.value {
        case .bee:
            break
        case .honey:
            if tile.state.isRevealed {
                return
            }
            self[tile.row, tile.col]?.state = .revealed
            if tile.value.isZero {
                openTilesAround(tile: tile)
            }
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
    
    func processTap(tile: Tile) {
        if !tile.value.isZero && isFirstTap {
            tiles = []
            populateBoard()
            assignNumberOfSurroundingBeesToTiles()
            processTap(tile: self[tile.row, tile.col]!)
            return
        }
        
        isFirstTap = false
        if tile.value.isBee {
            tile.state = .revealed
            gameState = .lost
            return
        }
        
        if tile.value.isZero {
            // Reveal all the other tiles with no bees around it
            revealAllZeroesAround(tile: tile)
        }
        
        tile.state = .revealed
        checkIsGameWon()
    }
    
    func processLongTap(tile: Tile) {
        if tile.state.isFlagged {
            tile.state = .notRevealed
            beesLeft += 1
        } else {
            tile.state = .flagged
            beesLeft -= 1
        }
    }
    
    func togglePause() {
        // If the game is paused, resume the game, if not, pause the game
        gameState = (gameState == .paused) ? .ongoing : .paused
    }
}
