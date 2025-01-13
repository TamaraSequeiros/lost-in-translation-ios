//
//  ContentView.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

enum CEFRLevel: String, Codable, CaseIterable, Identifiable, CodingKeyRepresentable {
    case A1
    case A2
    case B1
    case B2
    case C1
    case C2
    case Native
    
    var id: Self { self }
}
