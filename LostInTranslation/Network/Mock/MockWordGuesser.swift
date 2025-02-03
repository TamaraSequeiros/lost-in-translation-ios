//
//  MockWordGuesser.swift
//  LostInTranslation
//
//  Created by Tamara on 01/02/2025.
//


struct MockWordGuesser {
    private static let randomAnswers = [
        "Cat",
        "Dog",
        "Elephant",
        "Bird",
        "House",
        "Car",
        "Tree",
        "Book"
    ]
    
    static func guess(targetWord: String) -> String {
        // 50% chance to return the correct word
        let shouldGuessCorrectly = Bool.random()
        
        if shouldGuessCorrectly {
            return targetWord
        } else {
            return randomAnswers
                .filter { $0.lowercased() != targetWord.lowercased() }
                .randomElement() ?? randomAnswers[0]
        }
    }
} 