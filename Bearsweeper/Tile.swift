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
    var row: Int
    var col: Int

    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
}
