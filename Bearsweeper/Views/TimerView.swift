//
//  TimerView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-07.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var board: Board
    @EnvironmentObject private var timerViewModel: TimerViewModel
    
    var body: some View {
        Text(timerViewModel.tick)
            .font(.custom("NFPixels-Regular", size: 35))
            .foregroundColor(.yellow)
            .background(
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 80, height: 50)
                    .border(Color.yellow)
            )
            .frame(width: 52.5)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(board: Board(gameType: .beginner))
    }
}
