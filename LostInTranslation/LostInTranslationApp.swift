//
//  LostInTranslationApp.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import SwiftUI

@main
struct LostInTranslationApp: App {
    @StateObject private var settingsViewModel: SettingsViewModel = SettingsViewModel()
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(settingsViewModel)
                .environmentObject(navigationManager)
        }
    }
}
