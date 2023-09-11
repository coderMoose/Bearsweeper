//
//  MenuPopupView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-03.
//

import SwiftUI

struct MenuPopupView: View {
    @ObservedObject var board: Board
    let returnToMainViewTapped: () -> Void
    let newGameTapped: () -> Void
    
    var body: some View {
        VStack {
            if board.gameState == .won {
                Image("honey")
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            Text(board.gameState.displayText)
                .font(.title)
            HStack {
                returnToMainViewButton
                if board.gameState.isGameOver || board.gameState == .paused {
                    resumeButton
                }
            }
        }
        .frame(width: 350, height: 400)
        .background(Color.brown)
        .border(Color.black, width: 3)
    }
    
    private var returnToMainViewButton: some View {
        Button {
            withAnimation {
                returnToMainViewTapped()
            }
        } label: {
            Text("Main Menu")
                .padding()
                .background(Color.beige)
                .foregroundColor(.black)
                .bold()
                .cornerRadius(15)
        }
    }
        
    private var resumeButton: some View {
        Button {
            withAnimation {
                if board.gameState.isGameOver {
                    newGameTapped()
                } else {
                    board.gameState = .ongoing
                }
            }
        } label: {
            Text(board.gameState.isGameOver ? "Play Again!" : "Resume Game")
                .padding()
                .background(Color.beige)
                .foregroundColor(.black)
                .bold()
                .cornerRadius(15)
        }
    }
}

struct MenuPopupView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPopupView(board: Board(gameType: .beginner), returnToMainViewTapped: {}, newGameTapped: {})
    }
}
