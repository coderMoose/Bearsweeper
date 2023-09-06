//
//  RouterView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-04.
//

import SwiftUI

enum Screen {
    case gameView
    case mainView
}

struct RouterView: View {
    @State private var currentScreen = Screen.mainView
    @State private var board = Board(gameType: .beginner)
    
    var body: some View {
        switch currentScreen {
        case .gameView:
            GameView(board: board, returnToMainViewTapped: {
                currentScreen = .mainView
                board = Board(gameType: .beginner)
            }, newGameTapped: {
                board = Board(gameType: .beginner)
            })
            
        case .mainView:
            MainView(currentScreen: $currentScreen)
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
    }
}
