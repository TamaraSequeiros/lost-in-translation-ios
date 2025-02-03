//
//  MainView.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject var playerViewModel: PlayerViewModel
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
                        Image(systemName: "person.fill")
                        Text("One is fun")
                    }
                }
                .buttonStyle(.borderedProminent)
                .fontDesign(.rounded)
                .controlSize(.large)
                .padding(.bottom)
                
                Button {
                    navigationManager.navigate(to: .twoPeopleGame)
                } label: {
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("Double trouble")
                    }
                }
                .buttonStyle(.borderedProminent)
                .fontDesign(.rounded)
                .controlSize(.large)
                .padding(.bottom)
                
                Button {
                    navigationManager.navigate(to: .teamMatch)
                } label: {
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text("Team match")
                    }
                }
                .buttonStyle(.borderedProminent)
                .fontDesign(.rounded)
                .controlSize(.large)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    let player = playerViewModel.player
                    let playerName = player?.name ?? ""
                    let language = player?.language.rawValue ?? ""
                    let level = player?.level.rawValue ?? ""
                    let text = mainViewModel.displayedText(playerName: playerName, countryISO: language, level: level)
                    Button {
                        navigationManager.navigate(to: .player)
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
                case .twoPeopleGame:
                    // TODO: Implement two people game
                    Text("Coming soon...")
                case .teamMatch:
                    // TODO: Implement team match
                    Text("Coming soon...")
                case .player:
                    PlayerView()
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(PlayerViewModel())
}
