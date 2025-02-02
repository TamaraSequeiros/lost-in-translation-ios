//
//  ContentView.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import Foundation

struct StoredCard: Codable, Hashable {
    let id: String
    let targetWord: String
    let forbiddenWords: [CEFRLevel: [String]]

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: StoredCard, rhs: StoredCard) -> Bool {
        lhs.id == rhs.id
    }
}
