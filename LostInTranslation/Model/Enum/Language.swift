//
//  Language.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

enum Language : String, Codable, CaseIterable, Identifiable {
    case Dutch = "NL"
    case English = "GB"
    case Spanish = "ES"
    case Turkish = "TR"
    
    var id: Self { self }
}
