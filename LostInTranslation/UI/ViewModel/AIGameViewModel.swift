//
//  AIGameViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//


import Foundation
import UIKit

class AIGameViewModel: ObservableObject {
    
    #if DEBUG
    static var isDevMode = true
    #else
    static var isDevMode = false
    #endif
    
    var settings: GameSettings? = SettingsManager.shared.loadGameSettings()
    private let apiClient: WordGuessAPIClient
    
    init(apiClient: WordGuessAPIClient = WordGuessAPIClient()) {
        self.apiClient = apiClient
    }
    
    func getGuessedWord(from description: String, forbidden: [String]?, targetWord: String) -> String {
        if let forbidden = forbidden {
            let used = forbiddenAreUsed(description: description, forbidden: forbidden)
            if !used.isEmpty {
                return "Used forbidden word: \(used)"
            }
        }
        
        if AIGameViewModel.isDevMode {
            return MockWordGuesser.guess(targetWord: targetWord)
        }
        
        let result = apiClient.guessWord(description: description, language: "\(settings!.language)")
        switch result {
            case .success(let word):
                return word
            case .failure(let error):
                print(error)
                return "ERROR"
        }
    }
    
    func forbiddenAreUsed(description: String, forbidden: [String]) -> String {
        for forbiddenWord in forbidden {
            if description.lowercased().contains(forbiddenWord.lowercased()) {
                return forbiddenWord
            }
        }
        return ""
    }
}
