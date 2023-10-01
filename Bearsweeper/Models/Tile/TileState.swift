//
//  TileState.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-10.
//

import SwiftUI

enum TileState {
    case revealed
    case notRevealed
    case flagged
    
    var isRevealed: Bool {
        switch self {
        case .revealed:
            return true
        case .notRevealed, .flagged:
            return false
        }
    }
    
    var isNotRevealed: Bool {
        switch self {
        case .notRevealed:
            return true
        case .revealed, .flagged:
            return false
        }
    }
    
    var isFlagged: Bool {
        switch self {
        case .flagged:
            return true
        case .notRevealed, .revealed:
            return false
        }
    }
}
