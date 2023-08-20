//
//  GameState.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import Foundation

enum GameState {
    case won
    case lost
    case ongoing

    var displayText: String {
        switch self {
        case .won:
            return "You won!"
        case .lost:
            return "You lost :("
        case .ongoing:
            return ":D"
        }
    }
}
