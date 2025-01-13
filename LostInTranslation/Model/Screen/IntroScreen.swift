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

            Button("Start", systemImage: "play.circle") {
                appViewModel.currentScreen = .createUser
            }
            .buttonStyle(.borderedProminent)
            .fontDesign(.monospaced)
            .controlSize(.extraLarge)
            
            Spacer()
        }
    }
}
