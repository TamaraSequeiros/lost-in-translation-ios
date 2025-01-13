//
//  Language.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

enum Language : String, Codable, CaseIterable, Identifiable {
    case Dutch = "nl"
    case English = "en"
    case Spanish = "es"
    case Turkish = "tr"
    
    var id: Self { self }
}
