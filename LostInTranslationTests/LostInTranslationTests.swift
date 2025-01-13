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
        let viewModel = ViewModel()
        viewModel.loadCards()
        #expect(viewModel.allCards.isEmpty == false)
    }

}
