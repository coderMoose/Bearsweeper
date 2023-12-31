//
//  BearsweeperApp.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-18.
//

import SwiftUI

@main
struct BearsweeperApp: App {
    @StateObject private var timerViewModel = TimerViewModel()

    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(timerViewModel)
        }
    }
}
