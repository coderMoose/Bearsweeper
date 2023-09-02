//
//  BoardView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-02.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var board: Board
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                board(for: geo)
            }
            .border(Color.brown.gradient.shadow(.inner(radius: 10)), width: 2.5)
        }
    }
    
    private func board(for geo: GeometryProxy) -> some View {
        ForEach(0..<8, id: \.self) { row in
            HStack(spacing: 0) {
                ForEach(0..<8, id: \.self) { col in
                    let tileSize = tileSize(thatFits: geo.size)
                    let currentTile = board[row, col]
                    TileView(tile: currentTile!) { tile in
                        board.processTap(tile: tile)
                    } .frame(width: tileSize, height: tileSize)
                }
            }
        }
    }
    
    private func tileSize(thatFits size: CGSize) -> CGFloat {
        min(size.width / CGFloat(8),
            size.height / CGFloat(8))
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(board: Board(tileGenerator: FakeTileGenerator()))
    }
}
