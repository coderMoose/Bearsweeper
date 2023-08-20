//
//  Board.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import Foundation

class Board: ObservableObject {
    @Published var tiles: [Tile] = [Tile(row: 0, col: 0)]

    init() {
        populateBoard()
    }

    func tileAt(row: Int, col: Int) -> Tile? {
        //TODO: board is currently hardcoded to have 8 rows/columns, change this later on
        let index = (row * 8) + col
        return tiles[index]
    }

    private func populateBoard() {
        for row in 0..<8 {
            for col in 0..<8 {
                tiles.append(Tile(row: row, col: col))
            }
        }
    }
}
