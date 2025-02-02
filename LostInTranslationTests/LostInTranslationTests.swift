//
//  LostInTranslationTests.swift
//  LostInTranslationTests
//
//  Created by Tamara on 12/01/2025.
//

import Testing
@testable import LostInTranslation

struct LostInTranslationTests {

    @Test func testCardLoading() async throws {
        let gameViewModel = await GameViewModel()
        try await gameViewModel.loadCards()
        await #expect(gameViewModel.allCards.isEmpty == false)
    }

}
