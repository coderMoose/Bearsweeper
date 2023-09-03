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
            navBar
            Spacer()
            BoardView(board: board)
                .padding(3)
            Spacer()
        }
    }
    
    private var navBar: some View {
        HStack {
            Spacer()
            bearIcon
            Text(board.gameState.displayText)
            Spacer()
        }
        .padding()
        .background(Color.brown)
    }
    
    private var bearIcon: some View {
        Image(uiImage: UIImage(named: board.gameState.imageName)!)
            .resizable()
            .frame(width: 65, height: 65)
            .foregroundColor(.yellow)
            .onTapGesture {
                // bring up a popup view
            }
            .background(Color.beige)
            .border(Color.yellow)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
