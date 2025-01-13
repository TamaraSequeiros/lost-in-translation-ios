//
//  GameScreen.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct GameScreen: View {
    @EnvironmentObject var appViewModel: ViewModel
    @StateObject private var gameViewModel = ViewModel()

    var body: some View {
        VStack {
            if let targetWord = appViewModel.currentWord {
                Text(targetWord)
                    .font(.title)
                    .padding()

                ForEach(appViewModel.currentForbidden, id: \.self) { word in
                    Text(word)
                        .foregroundColor(.red)
                }
            } else {
                Text("No Card Loaded")
            }

            Button("Next Word") {
                appViewModel.loadNextCard()
            }
            .padding()
            
            Button("Exit to Main Menu") {
                appViewModel.currentScreen = .main
            }
            .buttonStyle(.bordered)
            .padding()
            
        }
        .onAppear {
            appViewModel.loadNextCard()
        }
    }
}

