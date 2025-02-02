//
//  GameViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import Foundation

class GameViewModel: ObservableObject {
    
    internal var allCards: [Card] = []
    @Published var currentWord: String?
    @Published var currentForbidden: [String] = []
    
    var player: Player? = UserManager.shared.loadUser()

    func loadCards() throws {
        guard let player = player else {
            throw CardLoadingError.noPlayerLoggedIn
        }
        try allCards = CardManager.shared.loadCards(language: player.language.rawValue)
    }
    
    func loadNextCard() throws {
        guard let player = player else {
            throw CardLoadingError.noPlayerLoggedIn
        }
        if allCards.isEmpty {
            do {
                try loadCards()
            } catch {
                print(error)
            }
        }
        guard !allCards.isEmpty else {
            throw CardLoadingError.noCardsAvailable
        }
        guard let card = allCards.randomElement() else {
            throw CardLoadingError.failedToGetRandomCard
        }
        
        currentWord = card.targetWord
        var forbiddenList: [String] = []
        
        for level in CEFRLevel.allCases where level <= player.level {
            forbiddenList.append(contentsOf: card.forbiddenWords[level]!)
        }
        currentForbidden = forbiddenList
    }
}
