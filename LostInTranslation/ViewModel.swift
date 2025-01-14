//
//  ViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    internal var allCards: [Card] = []
    @Published var currentWord: String?
    @Published var currentForbidden: [String] = []
    
    @Published var currentScreen: AppScreen = .intro
    @Published var player: Player = Player(name: "", language: .English, level: .A1) // default player data
    
    internal func loadCards() {
        // For now, loading cards from the JSON file
        let fileName = "cards." + player.language.rawValue
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
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
            var forbiddenList: [String] = []
            
            for level in CEFRLevel.allCases {
                forbiddenList.append(contentsOf: card.forbiddenWords[level]!)
                if level == player.level {
                    break
                }
            }
            currentForbidden = forbiddenList
        }
    }
    
    func savePlayer() {
        // Save user data to UserDefaults
        if let encoded = try? JSONEncoder().encode(player) {
            UserDefaults.standard.set(encoded, forKey: "player")
        }
        loadCards()
    }

    func loadPlayer() {
        // Load user data from UserDefaults
        if let savedPlayerData = UserDefaults.standard.data(forKey: "player"),
           let decodedPlayer = try? JSONDecoder().decode(Player.self, from: savedPlayerData) {
            player = decodedPlayer
        }
    }
}


