//
//  GameViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import Foundation

class GameViewModel: ObservableObject {
    
    internal var allCards: [StoredCard] = []
    @Published var currentRound = 1
    private var usedCardsInRound: Set<StoredCard> = []
    
    var settings: GameSettings? = SettingsManager.shared.loadGameSettings()

    init() {
        do {
            try loadCards()
        } catch {
            print("Failed to load cards: \(error)")
            // We'll handle this error in the view
        }
    }

    func loadCards() throws {
        guard let settings = settings else {
            throw CardLoadingError.noGameSettings
        }
        try allCards = CardManager.shared.loadCards(language: settings.language.rawValue)
    }
    
    func getNextCard() throws -> PlayingCard? {
        let maxRounds = settings!.numberOfRounds
        if currentRound > maxRounds {
            resetGame()
            return nil
        }
        let availableCards = allCards.filter { !usedCardsInRound.contains($0) }
        guard !availableCards.isEmpty else {
            throw CardLoadingError.noCardsAvailable
        }
        
        guard let nextCard = availableCards.randomElement() else {
            throw CardLoadingError.failedToGetRandomCard
        }
        usedCardsInRound.insert(nextCard)
        let playingCard = PlayingCard(from: nextCard, gameLevel: settings!.level, isLastCard: currentRound == maxRounds)
        currentRound += 1
        return playingCard
    }

    private func resetGame() {
        currentRound = 1
        usedCardsInRound.removeAll()
    }
}
