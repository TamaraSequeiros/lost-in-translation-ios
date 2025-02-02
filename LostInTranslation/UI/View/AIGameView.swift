//
//  AIGameView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI


struct AIGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var gameViewModel: GameViewModel = GameViewModel()
    @StateObject private var aiGameViewModel: AIGameViewModel = AIGameViewModel()
    
    @State private var errorMessage: String?
    
    @State private var wordDescription = ""
    @State private var aiGuess = ""
    @State private var submitted = false

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
                
                if submitted {
                    ResultView(
                        targetWord: gameViewModel.currentWord!,
                        guess: aiGuess,
                        onNextWord: {
                            submitted = false
                            wordDescription = ""
                            loadNext()
                        }
                    )
                } else {
                    InputSection(
                        wordDescription: $wordDescription,
                        onSubmit: {
                            submitted = true
                            aiGuess = aiGameViewModel.getGuessedWord(from: wordDescription, forbidden: gameViewModel.currentForbidden)
                        }
                    )
                }
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

private struct InputSection: View {
    @Binding var wordDescription: String
    let onSubmit: () -> Void
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditorView(text: $wordDescription)
            }
            
            Button(action: onSubmit) {
                HStack {
                    Text("Submit!")
                        .customFont(.title)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal, 50)
        }
    }
}

#Preview {
    AIGameView()
}
