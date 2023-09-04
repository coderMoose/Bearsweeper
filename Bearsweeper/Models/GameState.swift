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
    case paused

    var displayText: String {
        switch self {
        case .won:
            return "You won!"
        case .lost:
            return "You lost :("
        case .ongoing:
            return ":D"
        case .paused:
            return "Game paused"
        }
    }
    
    var imageName: String {
        switch self {
        case .won:
            return "bearCool"
        case .lost:
            return "bearRIP"
        case .ongoing:
            return "bearSmile"
        case .paused:
            return "bearShocked"
        }
    }
}
