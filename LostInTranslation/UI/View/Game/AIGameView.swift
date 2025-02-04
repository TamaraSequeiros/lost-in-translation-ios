//
//  AIGameView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI


struct AIGameView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var gameViewModel: GameViewModel = GameViewModel()
    @StateObject private var aiGameViewModel: AIGameViewModel = AIGameViewModel()
    @StateObject private var gameResultViewModel: GameResultViewModel = GameResultViewModel()

    @State private var errorMessage: String?
    @State private var currentCard: PlayingCard?

    @State private var gameState = GameState()

    let lapisLazuli = Color(red: 26 / 255, green: 101 / 255, blue: 158 / 255)
    
    struct GameState {
        var wordDescription = ""
        var aiGuess = ""
        var submitted = false
        
        mutating func submitGuess(_ guess: String) {
            self.aiGuess = guess
            self.submitted = true
        }
        
        mutating func reset() {
            self.wordDescription = ""
            self.aiGuess = ""
            self.submitted = false
        }
    }

    @State private var showGameResult = false
    
    var body: some View {
        ZStack {
             lapisLazuli.edgesIgnoringSafeArea(.all)
            VStack {
                if gameViewModel.allCards.isEmpty {
                    Text("Failed to load game cards")
                        .customFont(.body)
                        .foregroundColor(.red)
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .customFont(.body)
                        .foregroundColor(.red)
                        .padding()

                // Game logic
                } else if let card = currentCard {                    
                    CardView(targetWord: card.targetWord, forbiddenWords: card.forbiddenWords)
                    
                    if !gameState.submitted {
                        InputSection(
                            wordDescription: $gameState.wordDescription,
                            onSubmit: {
                                let guess = aiGameViewModel.getGuessedWord(
                                    from: gameState.wordDescription,
                                    forbidden: card.forbiddenWords,
                                    targetWord: card.targetWord
                                )
                                gameState.submitGuess(guess)
                            }
                        )
                        .padding()
                        .cornerRadius(15)
                    } else {
                        ResultView(
                            targetWord: card.targetWord,
                            guess: gameState.aiGuess,
                            isLastCard: card.isLastCard,
                            onNextWord: {
                                gameResultViewModel.submitGuessResult(isCorrect: gameState.aiGuess == card.targetWord)
                                loadNext()
                                gameState.reset()
                            }
                        )
                        .padding()
                        .cornerRadius(15)
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:
            Button(action: {
                navigationManager.popToRoot()
            }) {
                Text("Exit Game")
                    .foregroundColor(.black)
            }
        )
        .navigationDestination(isPresented: $showGameResult) {
            GameResultView(
                correctGuesses: gameResultViewModel.correctGuesses,
                totalGuesses: gameResultViewModel.totalGuesses
            )
        }
        .onAppear {
            loadNext()
        }
    }
    
    func loadNext() {
        do {
            if let nextCard = try gameViewModel.getNextCard() {
                currentCard = nextCard
            } else {
                showGameResult = true
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
    
    var isInputEmpty: Bool {
        wordDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            ZStack(alignment: .topLeading) {
                TextEditorView(text: $wordDescription)
                    .cornerRadius(10)
            }
            
            Button(action: onSubmit) {
                HStack {
                    Text("Submit!")
                        .customFont(.title)
                }
                .frame(width: 320)
                .padding()
                .background(isInputEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(isInputEmpty)
            .padding(.horizontal)
        }
    }
}

#Preview {
    AIGameView()
}
