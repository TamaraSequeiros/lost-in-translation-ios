//
//  ContentView.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import Foundation

struct Card: Codable {
    let targetWord: String
    let forbiddenWords: [CEFRLevel: [String]]
}

func loadCards() -> [Card] {
    if let url = Bundle.main.url(forResource: "cards", withExtension: "json"),
       let data = try? Data(contentsOf: url) {
        let cards = try? JSONDecoder().decode([Card].self, from: data)
        return cards ?? []
    }
    return []
}
