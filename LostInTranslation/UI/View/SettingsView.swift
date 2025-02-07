//
//  SettingsView.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settingsViewModel: SettingsViewModel;
    
    @State private var gameLanguage: Language = .English
    @State private var gameLevel: CEFRLevel = .A1
    @State private var numberOfRounds: Int = 5
    @State private var isSaveButtonEnabled: Bool = false

    var body: some View {
        VStack {
            Picker("Language", selection: $gameLanguage) {
                ForEach(Language.allCases) { language in
                    Text(String(describing: language))
                        .customFont(.body)
                }
            }
            .pickerStyle(.wheel)
            .padding(.horizontal, 20)
            
            Picker("Level", selection: $gameLevel) {
                ForEach(CEFRLevel.allCases) { level in
                    Text(String(describing: level))
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 50)
            .padding(.bottom, 50)
            
            Button("Save") {
                settingsViewModel.saveGameSettings(settings: GameSettings(language: gameLanguage, level: gameLevel, numberOfRounds: numberOfRounds))
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(!isSaveButtonEnabled)
            .customFont(.body)
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Game settings")
        .padding()
        .onAppear {
            gameLanguage = settingsViewModel.gameSettings?.language ?? .English
            gameLevel = settingsViewModel.gameSettings?.level ?? .A1
            numberOfRounds = settingsViewModel.gameSettings?.numberOfRounds ?? 5
        }
    }
}



#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
