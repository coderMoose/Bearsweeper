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
    var onLongTap: (Tile) -> Void
    
    var body: some View {
        ZStack {
            tileBackground
            
            if tile.value.isBee {
                Image("bee")
                    .resizable()
                    .colorMultiply(.yellow)
                    .opacity(tile.state.isRevealed ? 1.0 : 0.0)
            } else {
                Text(tile.value.displayText)
                    .foregroundColor(tile.value.textColor)
                    .shadow(color: .black, radius: 0.5)
                    .font(.custom("NFPixels-Regular", size: 45))
                    .opacity(tile.state.isRevealed ? 1.0 : 0.0)
            }
        }
    }
    
    private var tileBackground: some View {
        ZStack {
            Rectangle()
                .opacity(tile.state.isRevealed ? 1.0 : 0.0)
                .foregroundColor(.brown)
                .disabled(tile.state.isRevealed)
        
            Rectangle()
                .border(Color.brown.gradient.shadow(.inner(radius: 10)))
                .foregroundColor(tileForegroundColor)
                .onTapGesture {
                    withAnimation {
                        if !tile.state.isFlagged {
                            onTap(tile)
                        }
                    }
                }
                .onLongPressGesture {
                    withAnimation {
                        onLongTap(tile)
                    }
                }
        }
    }
    
    private var tileForegroundColor: Color {
        if tile.state.isFlagged {
            .red
        } else if tile.state.isRevealed {
            .clear
        } else {
            .beige
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(value: .honey(0), row: 0, col: 0), onTap: { _ in }, onLongTap: { _ in })
    }
}

extension Color {
    static let beige = Color("Beige")
}
