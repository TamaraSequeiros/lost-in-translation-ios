//
//  MainScreen.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var appViewModel: ViewModel

    var body: some View {
        VStack {
            Text("Language: \(appViewModel.player.language)")
                .font(.subheadline)

            Text("Level: \(appViewModel.player.level)")
                .font(.subheadline)
                .padding()

            Button("Start Game") {
                appViewModel.currentScreen = .game
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Button("Settings") {
                appViewModel.currentScreen = .createUser
            }
            .buttonStyle(.bordered)
            .padding()
        }
    }
}
