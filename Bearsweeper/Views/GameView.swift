//
//  GameView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-18.
//

import SwiftUI

struct GameView: View {
    @StateObject private var board = Board()
    
    var body: some View {
        VStack {
            Text(board.gameState.displayText)
            Spacer()
            boardView
            Spacer()
        }
        .background(Color.brown)
    }
    
    private var boardView: some View {
        VStack(spacing: 0) {
            ForEach(0..<8, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<8, id: \.self) { col in
                        let currentTile = board[row, col]
                        TileView(tile: currentTile!) { tile in
                            board.processTap(tile: tile)
                        }
                    }
                }
            }
        }
        .border(.green)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
