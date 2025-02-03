//
//  MainView.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct MainView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var playerViewModel: PlayerViewModel
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                
                NavigationLink(value: "ai_game") {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("One is fun")
                    }
                }
                .buttonStyle(.borderedProminent)
                .fontDesign(.rounded)
                .controlSize(.large)
                .padding(.bottom)
                
                NavigationLink(value: "two_people_game") {
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("Double trouble")
                    }
                }
                .buttonStyle(.borderedProminent)
                .fontDesign(.rounded)
                .controlSize(.large)
                .padding(.bottom)
                
                NavigationLink {
                    // TODO
                } label: {
                    Image(systemName: "person.3.fill")
                    Text("Team match")
                }
                .buttonStyle(.borderedProminent)
                .fontDesign(.rounded)
                .controlSize(.large)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { value in
                if value == "ai_game" {
                    AIGameView(path: $path)
                } else if value == "two_people_game" {
                    AIGameView(path: $path)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                let player = playerViewModel.player
                let playerName = player?.name ?? ""
                let language = player?.language.rawValue ?? ""
                let level = player?.level.rawValue ?? ""
                let text = mainViewModel.displayedText(playerName: playerName, countryISO: language, level: level)
                NavigationLink {
                    PlayerView()
                } label: {
                    Text(text)
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(PlayerViewModel())
}
