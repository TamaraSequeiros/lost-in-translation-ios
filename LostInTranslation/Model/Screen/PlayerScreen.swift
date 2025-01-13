//
//  CreateUserScreen.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct PlayerScreen: View {
    @EnvironmentObject var appViewModel: ViewModel
    @State private var playerName: String = ""
    @State private var playerLanguage: Language = .English
    @State private var playerLevel: CEFRLevel = .A1

    var body: some View {
        VStack {
            Text("Player profile")
                .font(.title)
                .padding()

//            TextField("Enter your name", text: $playerName)
//                .accessibility(identifier: "usernameTextField")
//                .textFieldStyle(.roundedBorder)
//                .padding()

            Picker("Select Language", selection: $playerLanguage) {
                ForEach(Language.allCases) { language in
                    Text(String(describing: language))
                }
            }
            .accessibility(identifier: "languagePicker")
            .pickerStyle(.inline)
            .padding()
            
            Picker("Select your level", selection: $playerLevel) {
                ForEach(CEFRLevel.allCases) { level in
                    Text(String(describing: level))
                }
            }
            .accessibility(identifier: "levelPicker")
            .pickerStyle(.segmented)

            Button("Save") {
                let newPlayer = Player(name: playerName, language: playerLanguage, level: playerLevel)
                appViewModel.player = newPlayer
                appViewModel.savePlayer()
                appViewModel.currentScreen = .main
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}
