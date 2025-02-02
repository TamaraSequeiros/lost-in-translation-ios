//
//  CardManager.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import Foundation

class CardManager {
    
    static let shared = CardManager()
    
    private init() {}
    
    func loadCards(language: String) throws -> [Card]  {
        let fileName = "cards." + language
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw CardLoadingError.jsonFileNotFound
        }
        
        do {
            let data = try Data(contentsOf: file)
            return try JSONDecoder().decode([Card].self, from: data)
        } catch {
            throw CardLoadingError.failedToDecodeJson
        }
    }
}
