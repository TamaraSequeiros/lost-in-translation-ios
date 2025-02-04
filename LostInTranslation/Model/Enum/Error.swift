//
//  Error.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

enum CardLoadingError: Error {
    case noGameSettings
    case noCardsAvailable
    case failedToGetRandomCard
    case jsonFileNotFound
    case failedToDecodeJson
}

