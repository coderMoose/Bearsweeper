//
//  GameView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-08-18.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
            Spacer()
            boardView
            Spacer()
        }.background(Color.brown)
    }
    
    private var boardView: some View {
        VStack(spacing: 0) {
            ForEach(0..<8, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<8, id: \.self) { col in
                        Rectangle()
                            .border(.green)
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
        .border(.green)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
