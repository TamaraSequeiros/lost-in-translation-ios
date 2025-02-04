//
//  SettingsManager.swift
//  LostInTranslation
//
//  Created by Tamara on 24/01/2025.
//

import Foundation

class SettingsManager {
    
    static let shared = SettingsManager()
    
    private init() {}
    
    private let settingsDefaultsKey = "LostInTranslation.settings"

    func saveGameSettings(settings: GameSettings?) {
        if let settings = settings {
            if let encodedSettings = try? JSONEncoder().encode(settings) {
                UserDefaults.standard.set(encodedSettings, forKey: settingsDefaultsKey)
            }
        } else {
            UserDefaults.standard.removeObject(forKey: settingsDefaultsKey)
        }
    }

    func loadGameSettings() -> GameSettings? {
        if let settingsData = UserDefaults.standard.data(forKey: settingsDefaultsKey),
           let decodedSettings = try? JSONDecoder().decode(GameSettings.self, from: settingsData) {
            return decodedSettings
        } else {
            return nil
        }
    }
    
    func deleteGameSettings() {
        UserDefaults.standard.removeObject(forKey: settingsDefaultsKey)
    }
}
