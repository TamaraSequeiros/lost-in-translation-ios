//
//  MainViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import Foundation

class MainViewModel: ObservableObject {
    
    func settingsMenuText(countryISO: String, level: String) -> String {
        return countryISO.isEmpty ? "Set your profile" : "Hi! \(flag(country: countryISO)) \(level)"
    }
    
    private func flag(country: String) -> String {
        let base : UInt32 = 127397 // Unicode flags index
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
