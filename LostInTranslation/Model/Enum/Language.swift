//
//  Language.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

enum Language: String, Codable, CaseIterable, Identifiable {
    case Dutch
    case English
    case Spanish
    case Turkish
    
    var id: String { rawValue }
    
    var localeIdentifier: String {
        switch self {
        case .Dutch: return "nl-NL"
        case .English: return "en-GB"
        case .Spanish: return "es-ES"
        case .Turkish: return "tr-TR"
        }
    }
    
    var countryISOCode: String {
        switch self {
        case .Dutch: return "NL"
        case .English: return "GB"
        case .Spanish: return "ES"
        case .Turkish: return "TR"
        }
    }
}
