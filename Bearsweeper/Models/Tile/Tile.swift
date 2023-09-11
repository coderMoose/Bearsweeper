//
//  Tile.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import Foundation

class Tile: ObservableObject, Identifiable {
    let id = UUID()
    @Published var state: TileState = .notRevealed
    var value: TileValue
    let row: Int
    let col: Int

    init(value: TileValue, row: Int, col: Int) {
        self.value = value
        self.row = row
        self.col = col
    }
}
