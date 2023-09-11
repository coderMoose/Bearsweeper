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
            beesLeftView
            Spacer()
            bearIcon
            Spacer()
            TimerView(board: board)
            Spacer()
        }
        .padding()
        .background(Color.brown)
    }
    
    private var beesLeftView: some View {
        HStack {
            Text(String(format: "%03d", board.beesLeft))
                .font(.custom("NFPixels-Regular", size: 35, relativeTo: .body))
                .foregroundColor(board.beesLeft >= 0 ? .yellow : .red)
        }
        .background(
            Rectangle()
                .foregroundColor(.black)
                .frame(width: 80, height: 50)
                .border(Color.yellow)
        )
    }
    
    private var bearIcon: some View {
        Image(board.gameState.imageName)
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
