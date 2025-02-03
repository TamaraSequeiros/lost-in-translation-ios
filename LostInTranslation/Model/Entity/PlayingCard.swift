import Foundation

struct PlayingCard {
    let targetWord: String
    let forbiddenWords: [String]
    let isLastCard: Bool
    
    init(from card: StoredCard, playerLevel: CEFRLevel, isLastCard: Bool) {
        self.targetWord = card.targetWord

        var words: [String] = []
        for level in CEFRLevel.allCases where level <= playerLevel {
            words.append(contentsOf: card.forbiddenWords[level]!)
        }
        self.forbiddenWords = words
        self.isLastCard = isLastCard
    }
} 
