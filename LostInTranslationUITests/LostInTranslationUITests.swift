//
//  LostInTranslationUITests.swift
//  LostInTranslationUITests
//
//  Created by Tamara on 12/01/2025.
//

import XCTest

final class LostInTranslationUITests: XCTestCase {

    func testStartButton() {
        // Launch the app
        let app = XCUIApplication()
        app.launch()

        // Assert that the "Start" button exists
        let startButton = app.buttons["Start"]
        XCTAssertTrue(startButton.exists, "Start button should be visible")

        // Tap the "Start Game" button
        startButton.tap()
        
        // TODO if there is already a registered player?
        
        // Assert that the player creation screen appears
        let playerProfileScreen = app.staticTexts["Player profile"]
        XCTAssertTrue(playerProfileScreen.exists, "Player profile screen should appear after tapping Start")
    }

    func testUserCreationScreen() {
        let app = XCUIApplication()
        app.launch()

        // Navigate to the user creation screen
        let startButton = app.buttons["Start"]
        startButton.tap()

        // Assert that the user creation screen is displayed
        let playerProfileScreen = app.staticTexts["Player profile"]
        XCTAssertTrue(app.textFields["usernameTextField"].exists, "User name text field should exist")
    }

}
