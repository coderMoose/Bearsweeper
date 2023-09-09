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
                .foregroundColor(.brown)
        
            Rectangle()
                .border(Color.brown.gradient.shadow(.inner(radius: 10)))
                .foregroundColor(tile.isRevealed ? .clear : .beige)
                .disabled(tile.isRevealed)
                .onTapGesture {
                    withAnimation {
                        onTap(tile)
                    }
                }
            
            if tile.value.isBee {
                Image(uiImage: UIImage(named: "bee")!)
                    .resizable()
                    .colorMultiply(.yellow)
                    .opacity(tile.isRevealed ? 1.0 : 0.0)
            } else {
                Text(tile.value.displayText)
                    .foregroundColor(tile.value.textColor)
                    .shadow(color: .black, radius: 4)
                    .font(.custom("NFPixels-Regular", size: 35))
                    .opacity(tile.isRevealed ? 1.0 : 0.0)
            }
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(value: .honey(0), row: 0, col: 0), onTap: { _ in })
    }
}

extension Color {
    static let beige = Color("Beige")
}
