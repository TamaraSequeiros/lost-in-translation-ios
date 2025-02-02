struct MockWordGuesser {
    static let responses = [
        "Cat",
        "Dog",
        "Elephant",
        "Bird"
    ]
    
    static func guess() -> String {
        return responses.randomElement() ?? responses[0]
    }
} 