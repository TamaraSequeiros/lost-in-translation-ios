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
    
    @State private var isBouncingArrow = false
    
    var body: some View {
        let settings = settingsViewModel.gameSettings
        
        NavigationStack(path: $navigationManager.path) {
            VStack() {
                HStack {
                    Spacer()
                    if settings == nil {
                        VStack(alignment: .trailing) {
                            Text("Configure game settings!")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.blue.opacity(0.7))
                                .cornerRadius(10)
                                .onTapGesture {
                                    navigationManager.navigate(to: .settings)
                                }
                            
                            Image("orange_arrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .shadow(color: .black, radius: 2)
                                .offset(x: -20, y: 15)
                                .offset(y: isBouncingArrow ? -10 : 0)
                                .animation(
                                    .easeInOut(duration: 0.5)
                                    .repeatForever(autoreverses: true),
                                    value: isBouncingArrow
                                )
                        }
                        .transition(.opacity)
                        .animation(.easeInOut, value: settings == nil)
                        .onAppear {
                            isBouncingArrow = true
                        }
                    } else {
                        Button {
                            navigationManager.navigate(to: .settings)
                        } label: {
                            let country = settings?.language.countryISOCode ?? ""
                            let level = settings?.level.rawValue ?? ""
                            Text(mainViewModel.settingsMenuText(countryISO: country, level: level))
                        }
                    }
                }
                .padding()
                
                VStack {
                    Image("LiT_logo_bw")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 10)
                    
                    Text("Lost In Translation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 50)
                    
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
                    .disabled(settings == nil)
                }
                Spacer()
            }
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
