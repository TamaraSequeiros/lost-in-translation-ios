//
//  AIGameView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI


struct AIGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    @StateObject private var gameViewModel: GameViewModel = GameViewModel()
    @StateObject private var aiGameViewModel: AIGameViewModel = AIGameViewModel()
    
    @State private var errorMessage: String?
    @State private var currentCard: PlayingCard?
    @State private var wordDescription = ""
    @State private var aiGuess = ""
    @State private var submitted = false

    var body: some View {
        ZStack {
            Color.indigo.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if gameViewModel.allCards.isEmpty {
                    Text("Failed to load game cards")
                        .foregroundColor(.red)
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                } else if let card = currentCard {
                    CardView(targetWord: card.targetWord, forbiddenWords: card.forbiddenWords)
                    
                    if submitted {
                        ResultView(
                            targetWord: card.targetWord,
                            guess: aiGuess,
                            isLastCard: card.isLastCard,
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
                                aiGuess = aiGameViewModel.getGuessedWord(
                                    from: wordDescription,
                                    forbidden: card.forbiddenWords
                                )
                            }
                        )
                    }
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
            if let nextCard = try gameViewModel.getNextCard() {
                currentCard = nextCard
            } else {
                // End of game
                dismiss()
            }
        } catch {
            print("Error loading next card: \(error)")
            errorMessage = "Failed to load next card."
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
