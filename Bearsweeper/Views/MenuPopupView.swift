//
//  MenuPopupView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-03.
//

import SwiftUI

struct MenuPopupView: View {
    @ObservedObject var board: Board
    let newGameTapped: () -> Void
    
    var body: some View {
        VStack {
            Text(board.gameState.displayText)
                .font(.title)
            resumeButton
        }
        .frame(width: 300, height: 300)
        .background(Color.brown)
        .border(Color.black, width: 3)
    }
    
    private var resumeButton: some View {
        Button {
            withAnimation {
                if board.gameState == .lost {
                    newGameTapped()
                }
            }
        } label: {
            Text(board.gameState == .lost ? "Play Again!" : "Resume Game")
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
        MenuPopupView(board: Board(), newGameTapped: {})
    }
}
