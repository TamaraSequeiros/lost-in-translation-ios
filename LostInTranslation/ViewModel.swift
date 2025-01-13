//
//  ViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import Foundation

class ViewModel: ObservableObject {
    internal var allCards: [Card] = []
    @Published var currentWord: String?
    @Published var currentForbidden: [String] = []
    
    @Published var currentScreen: AppScreen = .intro
    @Published var player: Player = Player(name: "", level: .A1) // default player data

    init() {
        loadCards()
        loadNextCard()
    }

    internal func loadCards() {
        // For now, loading cards from the JSON file
        guard let file = Bundle.main.url(forResource: "cards", withExtension: "json") else {
            print("JSON file not found!")
            return
        }
        do {
            let data = try Data(contentsOf: file)
            allCards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print("Failed to load or decode JSON: \(error)")
        }
    }

    func loadNextCard() {
        guard !allCards.isEmpty else {
            print("Oops, no cards!")
            currentWord = nil
            currentForbidden = []
            return
        }

        if let card = allCards.randomElement() {
            currentWord = card.targetWord
            currentForbidden = card.forbiddenWords[player.level] ?? []
        }
    }
    
    func savePlayer() {
       // Save user data to UserDefaults
       if let encoded = try? JSONEncoder().encode(player) {
           UserDefaults.standard.set(encoded, forKey: "player")
       }
    }

    func loadPlayer() {
       // Load user data from UserDefaults
       if let savedPlayerData = UserDefaults.standard.data(forKey: "player"),
          let decodedPlayer = try? JSONDecoder().decode(Player.self, from: savedPlayerData) {
           player = decodedPlayer
       }
    }
}


