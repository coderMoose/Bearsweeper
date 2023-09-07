//
//  TimerView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-07.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var board: Board
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var startDate = Date.now
    @State private var timeElapsed: Int = 0
    
    var body: some View {
        Text(timeElapsed >= 999 ? "999" : String(format: "%03d", timeElapsed))
            .font(.custom("NFPixels-Regular", size: 35))
            .foregroundColor(.yellow)
            .background(
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 80, height: 50)
                    .border(Color.yellow)
            )
            .onReceive(timer) { firedDate in
                if board.gameState.isGameOver {
                    timer.upstream.connect().cancel()
                } else {
                    timeElapsed = Int(firedDate.timeIntervalSince(startDate))
                }
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(board: Board(gameType: .beginner))
    }
}
