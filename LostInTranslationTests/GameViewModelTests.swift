import XCTest
@testable import LostInTranslation

class GameViewModelTests: XCTestCase {
    var gameViewModel: GameViewModel!
    
    override func setUp() {
        super.setUp()
        gameViewModel = GameViewModel()
        // Set up test cards
        gameViewModel.allCards = [
            StoredCard(id: "1", targetWord: "Dog", forbiddenWords: [
                .A1: [],
                .A2: ["Pet"],
                .B1: ["Animal"],
                .B2: ["Bark"],
                .C1: ["Puppy"],
                .C2: ["Canine"]
            ]),
            StoredCard(id: "2", targetWord: "Cat", forbiddenWords: [
                .A1: [],
                .A2: ["Pet"],
                .B1: ["Animal"],
                .B2: ["Meow"],
                .C1: ["Kitten"],
                .C2: ["Feline"]
            ]),
            StoredCard(id: "3", targetWord: "Bird", forbiddenWords: [
                .A1: [],
                .A2: ["Fly"],
                .B1: ["Wings"],
                .B2: ["Sky"],
                .C1: ["Feathers"],
                .C2: ["Nest"]
            ]),
            StoredCard(id: "4", targetWord: "Tiger", forbiddenWords: [
                .A1: [],
                .A2: ["Cat"],
                .B1: ["Stripes"],
                .B2: ["Wild"],
                .C1: ["Jungle"],
                .C2: ["Predator"]
            ]),
            StoredCard(id: "5", targetWord: "Lion", forbiddenWords: [
                .A1: [],
                .A2: ["Cat"],
                .B1: ["King"],
                .B2: ["Africa"],
                .C1: ["Pride"],
                .C2: ["Mane"]
            ]),
            StoredCard(id: "6", targetWord: "Elephant", forbiddenWords: [
                .A1: [],
                .A2: ["Big"],
                .B1: ["Trunk"],
                .B2: ["Africa"],
                .C1: ["Tusk"],
                .C2: ["Pachyderm"]
            ])
        ]
    }
    
    func testRoundProgression() throws {
        XCTAssertEqual(gameViewModel.currentRound, 1, "Game should start at round 1")
        
        var usedCards = Set<String>()
        for i in 1...5 {
            XCTAssertEqual(gameViewModel.currentRound, i, "Game rounds should advance")
            let card = try gameViewModel.getNextCard()
            XCTAssertNotNil(card, "Should get a card")
            if let cardWord = card?.targetWord {
                XCTAssertFalse(usedCards.contains(cardWord), "Should not repeat cards within a round")
                usedCards.insert(cardWord)
            }
        }
    }
    
    func testGameCompletion() throws {
        // Play through all 5 rounds
        for _ in 1...5 {
            _ = try gameViewModel.getNextCard()
        }
        
        let noMoreCard = try gameViewModel.getNextCard()
        XCTAssertNil(noMoreCard, "Should return nil after 5 rounds")
        XCTAssertEqual(gameViewModel.currentRound, 1, "Game should reset")
    }
    
} 
