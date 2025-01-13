//
//  ContentView.swift
//  LostInTranslation
//
//  Created by Tamara on 12/01/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appViewModel = ViewModel()

    var body: some View {
        Group  {
            switch appViewModel.currentScreen {
            case .intro:
                IntroScreen()
                    .environmentObject(appViewModel)
            case .createUser:
                PlayerScreen()
                    .environmentObject(appViewModel)
            case .main:
                MainScreen()
                    .environmentObject(appViewModel)
            case .game:
                GameScreen()
                    .environmentObject(appViewModel)
            }
        }
        .environmentObject(appViewModel)
        .onAppear {
            appViewModel.loadPlayer()
        }
    }
}

#Preview {
    ContentView()
}
