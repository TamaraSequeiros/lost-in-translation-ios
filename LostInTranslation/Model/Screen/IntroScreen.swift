//
//  IntroScreen.swift
//  LostInTranslation
//
//  Created by Tamara on 13/01/2025.
//

import SwiftUI

struct IntroScreen: View {
    @EnvironmentObject var appViewModel: ViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("Lost In Translation")
                .font(.largeTitle)
                .fontWeight(.bold)
            Image(systemName: "globe") // Replace with your logo
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Spacer()
            Button("Start") {
                appViewModel.currentScreen = .createUser
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}
