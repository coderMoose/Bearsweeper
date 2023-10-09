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

    @Published private(set) var tick = "000"
    
    private var numSeconds = 0 {
        didSet {
            tick = String(format: "%03d", numSeconds)
        }
    }
    
    func startTimer() {
        numSeconds = 0
        resumeTimer()
    }
    
    func resumeTimer() {
        assignCancellable = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.numSeconds += 1
            })
    }
    
    func pause() {
        cancel()
    }
    
    func cancel() {
        assignCancellable?.cancel()
    }
}
