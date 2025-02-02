//
//  PlayerView.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct PlayerView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var playerViewModel: PlayerViewModel;
    
    @State private var playerName: String = ""
    @State private var playerLanguage: Language = .English
    @State private var playerLevel: CEFRLevel = .A1
    
    @State private var isSaveButtonEnabled: Bool = false

    var body: some View {
        VStack {
            Text("Player profile")
                .customFont(.title)
                .padding(.bottom, 50)
            
            TextField("Your name", text: $playerName)
                .onChange(of: playerName) {
                    isSaveButtonEnabled = !playerName.isEmpty
                }
                .customFont(.body)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                .padding(.horizontal, 50)

            Picker("Language", selection: $playerLanguage) {
                ForEach(Language.allCases) { language in
                    Text(String(describing: language))
                        .customFont(.body)
                }
            }
            .pickerStyle(.wheel)
            .padding(.horizontal, 20)
            
            Picker("Level", selection: $playerLevel) {
                ForEach(CEFRLevel.allCases) { level in
                    Text(String(describing: level))
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 50)
            .padding(.bottom, 50)
            
            Button("Save") {
                playerViewModel.savePlayer(newPlayer: Player(name: playerName, language: playerLanguage, level: playerLevel))
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(!isSaveButtonEnabled)
            .customFont(.body)
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Create User")
        .padding()
        .onAppear {
            playerName = playerViewModel.player?.name ?? ""
            playerLanguage = playerViewModel.player?.language ?? .English
            playerLevel = playerViewModel.player?.level ?? .A1
        }
    }
}



#Preview {
    PlayerView()
        .environmentObject(PlayerViewModel())
}
