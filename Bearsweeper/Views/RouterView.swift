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
    @EnvironmentObject private var timerViewModel: TimerViewModel
    
    var body: some View {
        switch currentScreen {
        case .gameView:
            GameView(board: board, returnToMainViewTapped: {
                currentScreen = .mainView
                board = Board(gameType: .beginner)
                timerViewModel.startTimer()
            }, newGameTapped: {
                board = Board(gameType: .beginner)
                timerViewModel.startTimer()
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
