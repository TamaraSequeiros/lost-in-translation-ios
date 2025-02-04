//
//  SettingsViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 18/01/2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    @Published var gameSettings: GameSettings?
    
    func saveGameSettings(settings: GameSettings?) {
        print("Saving settings: \(String(describing: settings))")
        gameSettings = settings
        SettingsManager.shared.saveGameSettings(settings: gameSettings)
    }

    init() {
        gameSettings = SettingsManager.shared.loadGameSettings()
    }
    
    func deleteGameSettings() {
        gameSettings = nil
        SettingsManager.shared.deleteGameSettings()
    }
}

