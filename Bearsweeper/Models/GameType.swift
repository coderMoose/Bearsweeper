//
//  GameType.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-04.
//

import Foundation

enum GameType {
    case beginner
    
    var numRows: Int {
        switch self {
        case .beginner:
            return 10
        }
    }
    
    var numColumns: Int {
        switch self {
        case .beginner:
            return 6
        }
    }
    
    var numBees: Int {
        switch self {
        case .beginner:
            return 10
        }
    }
    
    var numTiles: Int {
        numRows * numColumns
    }
    
    var numSafeTiles: Int {
        numTiles - numBees
    }
}
