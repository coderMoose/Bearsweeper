//
//  TileValue.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-20.
//

import SwiftUI

enum TileValue {
    case honey(Int) // a safe tile
    case bee // a mine
    
    var displayText: String {
        switch self {
        case .honey(let numOfBeesAround):
            return numOfBeesAround == 0 ? "" : String(numOfBeesAround)
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
    
    var textColor: Color {
        switch self {
        case .honey(let num):
            if num == 8 {
                return .gray
            } else if num == 7 {
                return .black
            } else if num == 6 {
                return .teal
            }  else if num == 5 {
                return .red
            } else if num == 4 {
                return .indigo
            } else if num == 3 {
                return .red
            } else if num == 2 {
                return .green
            } else if num == 1 {
                return .cyan
            }
            return .red
        case .bee:
            return .red
        }
    }
}
