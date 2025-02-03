//
//  LostInTranslationApp.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import SwiftUI

@main
struct LostInTranslationApp: App {
    @StateObject private var playerViewModel: PlayerViewModel = PlayerViewModel()
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(playerViewModel)
                .environmentObject(navigationManager)
        }
    }
}
