//
//  Tile.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import Foundation

class Tile: ObservableObject, Identifiable {
    let id = UUID()
    @Published var isRevealed: Bool = false
    var value: TileValue
    var row: Int
    var col: Int

    init(value: TileValue, row: Int, col: Int) {
        self.value = value
        self.row = row
        self.col = col
    }
}
