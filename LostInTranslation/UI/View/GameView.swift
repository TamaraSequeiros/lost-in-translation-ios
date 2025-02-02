//
//  GameView.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI


struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var gameViewModel: GameViewModel = GameViewModel()
    
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            Color.indigo.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                }
                
                CardView(targetWord: gameViewModel.currentWord, forbiddenWords: gameViewModel.currentForbidden)
                
                Button(action: {
                    loadNext()
                }) {
                    HStack {
                        Text("Next!")
                            .customFont(.title)
                        Image(systemName: "arrow.right")
                            .customFont(.title)
                    }
                    .frame(minWidth: 0, maxWidth: 250)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 50)
                .padding(.top, 100)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Exit Game")
            }
        )
        .onAppear {
            loadNext()
        }
    }
    
    func loadNext() {
        do {
            try gameViewModel.loadNextCard()
        } catch {
            errorMessage = "Failed to load next card. Oops."
        }
    }
}

#Preview {
    GameView()
}
