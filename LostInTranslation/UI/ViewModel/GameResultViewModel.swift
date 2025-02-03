//
//  GameResultViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 03/02/2025.
//

import Foundation

class GameResultViewModel: ObservableObject {
    @Published var correctGuesses: Int = 0
    @Published var totalGuesses: Int = 0

    func submitGuessResult(isCorrect: Bool) {
        totalGuesses += 1
        if isCorrect {
            correctGuesses += 1
        }
    }

    func resetScore() {
        correctGuesses = 0
        totalGuesses = 0
    }

}
