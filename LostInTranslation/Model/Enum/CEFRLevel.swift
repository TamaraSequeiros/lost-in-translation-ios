//
//  ContentView.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

enum CEFRLevel: String, Codable, CaseIterable, Identifiable, CodingKeyRepresentable, Comparable {
    case A1
    case A2
    case B1
    case B2
    case C1
    case C2
    
    var id: Self { self }
    
    var caseIndex: Int {
        return CEFRLevel.allCases.firstIndex(of: self)!
    }
    
    static func < (lhs: CEFRLevel, rhs: CEFRLevel) -> Bool {
        return lhs.caseIndex < rhs.caseIndex
    }

}
