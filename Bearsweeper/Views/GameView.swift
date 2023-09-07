//
//  GameView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-18.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var board: Board
    let returnToMainViewTapped: () -> Void
    let newGameTapped: () -> Void
    
    var body: some View {
        ZStack {
            gameView
                .background(Color.beige)
                .disabled(board.gameState.isNotOngoing)
            if board.gameState.isNotOngoing {
                MenuPopupView(board: board, returnToMainViewTapped: returnToMainViewTapped, newGameTapped: newGameTapped)
            }
        }
    }
    
    private var gameView: some View {
        VStack {
            navBar
            Spacer()
            BoardView(board: board)
                .padding(4)
                .background(Color.brown)
                .padding(3)
            Spacer()
        }
    }
    
    private var navBar: some View {
        HStack {
            Spacer()
            bearIcon
            Spacer()
            TimerView(board: board)
            Spacer()
        }
        .padding()
        .background(Color.brown)
    }
    
    private var bearIcon: some View {
        Image(uiImage: UIImage(named: board.gameState.imageName)!)
            .resizable()
            .frame(width: 65, height: 65)
            .onTapGesture {
                withAnimation {
                    board.togglePause()
                }
            }
            .background(Color.beige)
            .border(Color.black)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(board: Board(gameType: .beginner), returnToMainViewTapped: {}, newGameTapped: {})
    }
}
