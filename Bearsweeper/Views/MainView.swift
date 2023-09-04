//
//  MainView.swift
//  Bearsweeper
//
//  Created by Daniel on 2023-09-04.
//

import SwiftUI

struct MainView: View {
    @Binding var currentScreen: Screen
    
    var body: some View {
        VStack {
            navBar
            Spacer()
            ZStack {
                newGameButton
            }
            Spacer()
        }
        .background(Color.beige)
    }
  
    private var newGameButton: some View {
        Button {
            withAnimation {
                currentScreen = .gameView
            }
        } label: {
            Text("New Game")
                .font(.largeTitle)
                .padding()
                .background(Color.brown)
                .cornerRadius(10)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
    }
    
    private var navBar: some View {
        HStack {
            Spacer()
            Text("BEARSWEEPER")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.yellow)
            Spacer()
        }
        .padding()
        .background(Color.brown)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(currentScreen: .constant(.mainView))
    }
}
