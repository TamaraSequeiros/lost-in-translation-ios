//
//  ResultView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI

struct ResultView: View {
    
    @State var targetWord: String
    @State var guess: String
    
    let onNextWord: () -> Void
    
    var body: some View {
        VStack {
            ResultSection(targetWord: targetWord, guess: guess)
            
            Button(action: onNextWord) {
                HStack {
                    Text("Next word!")
                        .customFont(.title)
                    Image(systemName: "arrow.right")
                        .customFont(.title)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal, 50)
        }
    }
}


private struct ResultSection: View {
    
    let targetWord: String
    let guess: String

    var body: some View {
        if guess == targetWord {
            HStack {
                Text(guess)
                    .customFont(.title)
                Image(systemName: "party.popper.fill")
                    .customFont(.title)
            }
            .frame(width: 300, height: 200)
            .foregroundColor(.green)
        } else if guess.starts(with: "Used forbidden word") {
            Text(guess)
                .customFont(.title)
                .frame(width: 300, height: 200)
                .foregroundColor(.red)
        } else {
            VStack {
                Text(":( wrong guess")
                    .customFont(.title)
                Text("\"\(guess)\"")
                    .customFont(.title)
            }
            .frame(width: 300, height: 200)
            .foregroundColor(.red)
            
        }
    }
    
}
