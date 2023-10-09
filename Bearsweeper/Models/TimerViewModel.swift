//
//  TimerViewModel.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-10-08.

//  This code is adapted from https://stackoverflow.com/a/57806993 (thanks)

import Combine
import SwiftUI

class TimerViewModel: ObservableObject {
    private var assignCancellable: AnyCancellable? = nil

    @Published var tick = "0"
    
    private var numSeconds = 0
    
    func startTimer() {
        tick = "0"
        numSeconds = 0
        resumeTimer()
    }
    
    func resumeTimer() {
        assignCancellable = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .map { [self] _ in
                numSeconds += 1
                return String(numSeconds)
            }
            .assign(to: \TimerViewModel.tick, on: self)
    }
    
    func pause() {
        cancel()
    }
    
    func cancel() {
        assignCancellable?.cancel()
    }
}
