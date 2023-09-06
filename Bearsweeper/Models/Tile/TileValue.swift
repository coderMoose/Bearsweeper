//
//  TileValue.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import Foundation

enum TileValue {
    case honey(Int) // a safe tile
    case bee // a mine
    
    var displayText: String {
        switch self {
        case .honey(let numOfBeesAround):
            return numOfBeesAround == 0 ? "0" : String(numOfBeesAround)
        case .bee:
            return "BEE"
        }
    }
    
    var isHoney: Bool {
        switch self {
        case .honey:
            return true
        case .bee:
            return false
        }
    }
    
    var isBee: Bool {
        switch self {
        case .bee:
            return true
        case .honey:
            return false
        }
    }
    
    var isZero: Bool {
        switch self {
        case .honey(let num):
            return num == 0
        case .bee:
            return false
        }
    }
}
