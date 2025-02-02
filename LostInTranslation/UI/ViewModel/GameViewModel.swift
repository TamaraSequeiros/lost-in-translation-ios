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
    private let maxRounds = 5
    private var usedCardsInRound: Set<StoredCard> = []
    
    var player: Player? = UserManager.shared.loadUser()

    init() {
        do {
            try loadCards()
        } catch {
            print("Failed to load cards: \(error)")
            // We'll handle this error in the view
        }
    }

    func loadCards() throws {
        guard let player = player else {
            throw CardLoadingError.noPlayerLoggedIn
        }
        try allCards = CardManager.shared.loadCards(language: player.language.rawValue)
    }
    
    func getNextCard() throws -> PlayingCard? {
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
        currentRound += 1
        return PlayingCard(from: nextCard, playerLevel: player!.level)
    }

    private func resetGame() {
        currentRound = 1
        usedCardsInRound.removeAll()
    }
}
