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
    
    let themes = ["Dark", "Light", "Automatic"]
    @State private var selectedTheme = "Dark"
    
    private let roundOptions = [5, 10, 15]

    var body: some View {
        Text("Game settings")
            .customFont(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 40)
            .padding(.horizontal, 55)
        
        VStack {
            Form {
                Section(header: Text("Language and level").font(.headline)) {
                    Picker("Language", selection: $gameLanguage) {
                        ForEach(Language.allCases) { language in
                            Text(String(describing: language))
                                .customFont(.body)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                    Picker("Level", selection: $gameLevel) {
                        ForEach(CEFRLevel.allCases) { level in
                            Text(String(describing: level))
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                }
                
                Section(header: Text("Number of rounds per game").font(.headline)) {
                    Picker("Rounds", selection: $numberOfRounds) {
                        ForEach(roundOptions, id: \.self) { rounds in
                            Text("\(rounds)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                }
            }
            .scrollContentBackground(.hidden)
            .frame(height: 350)
            
            Button("Save") {
                settingsViewModel.saveGameSettings(settings: GameSettings(
                    language: gameLanguage,
                    level: gameLevel,
                    numberOfRounds: numberOfRounds
                ))
                presentationMode.wrappedValue.dismiss()
            }
            .customFont(.body)
            .buttonStyle(.borderedProminent)
            .padding()
            
        }
        .padding()
        .onAppear {
            gameLanguage = settingsViewModel.gameSettings?.language ?? .English
            gameLevel = settingsViewModel.gameSettings?.level ?? .A1
            numberOfRounds = settingsViewModel.gameSettings?.numberOfRounds ?? 5
        }
        Spacer()
    }
}



#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
