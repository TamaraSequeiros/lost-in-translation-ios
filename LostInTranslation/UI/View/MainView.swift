//
//  MainView.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack(spacing: 20) {
                Image("LiT_logo_bw")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding(.bottom, 10)
                
                Text("Lost In Translation")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Button {
                    navigationManager.navigate(to: .aiGame)
                } label: {
                    HStack {
                        Image(systemName: "play")
                        Text("Start game")
                    }
                }
                .buttonStyle(.borderedProminent)
                .fontDesign(.rounded)
                .controlSize(.large)
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    let settings = settingsViewModel.gameSettings
                    let language = settings?.language.rawValue ?? ""
                    let level = settings?.level.rawValue ?? ""
                    let text = mainViewModel.displayedText(countryISO: language, level: level)
                    Button {
                        navigationManager.navigate(to: .settings)
                    } label: {
                        Text(text)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AppScreen.self) { screen in
                switch screen {
                case .aiGame:
                    AIGameView()
                case .settings:
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SettingsViewModel())
        .environmentObject(NavigationManager())
}
