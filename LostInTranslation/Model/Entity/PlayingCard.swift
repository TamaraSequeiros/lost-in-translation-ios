import Foundation

struct PlayingCard {
    let targetWord: String
    let forbiddenWords: [String]
    
    init(from card: StoredCard, playerLevel: CEFRLevel) {
        self.targetWord = card.targetWord

        var words: [String] = []
        for level in CEFRLevel.allCases where level <= playerLevel {
            words.append(contentsOf: card.forbiddenWords[level]!)
        }
        self.forbiddenWords = words
    }
} 
