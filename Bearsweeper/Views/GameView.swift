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
            BoardView(board: board)
                .padding()
            Spacer()
        }
        .background(Color.brown.gradient)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
