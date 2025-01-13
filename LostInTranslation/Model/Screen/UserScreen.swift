//
//  CreateUserScreen.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct UserScreen: View {
    @EnvironmentObject var appViewModel: ViewModel
    @State private var newUserName: String = ""
    @State private var newUserLevel: CEFRLevel = .A1

    var body: some View {
        VStack {
            Text("Player profile")
                .font(.title)
                .padding()

            TextField("Enter your name", text: $newUserName)
                .accessibility(identifier: "usernameTextField")
                .textFieldStyle(.roundedBorder)
                .padding()

            Picker("Select your level", selection: $newUserLevel) {
                ForEach(CEFRLevel.allCases) { option in
                    Text(String(describing: option))
                }
            }
            .pickerStyle(.wheel)

            Button("Save") {
                let newPlayer = Player(name: newUserName, level: newUserLevel)
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
