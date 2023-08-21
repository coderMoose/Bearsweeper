//
//  TileView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import SwiftUI

struct TileView: View {
    @ObservedObject var tile: Tile
    var onTap: (Tile) -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(tile.isRevealed ? 1.0 : 0.0)
                .foregroundColor(.yellow)
                .frame(width: 50, height: 50)
        
            Rectangle()
                .border(.green)
                .frame(width: 50, height: 50)
                        .foregroundColor(tile.isRevealed ? .clear : .black)
                .disabled(tile.isRevealed)
                .onTapGesture {
                    withAnimation {
                        onTap(tile)
                    }
                }
            Text(tile.value.displayText)
                .foregroundColor(.white)
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(value: .honey(0), row: 0, col: 0), onTap: { _ in })
    }
}
