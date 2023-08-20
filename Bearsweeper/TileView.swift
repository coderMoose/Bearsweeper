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
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(row: 0, col: 0), onTap: { _ in })
    }
}
