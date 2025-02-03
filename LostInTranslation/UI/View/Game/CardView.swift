//
//  CardView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI

struct CardView: View {
    let targetWord: String?
    let forbiddenWords: [String]?

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            if let targetWord = targetWord {
                Text(targetWord)
                    .customFont(.title)
                    .padding(10)
                    .cornerRadius(10)
            }
            if let forbiddenWords = forbiddenWords {
                ForEach(forbiddenWords, id: \.self) { word in
                    Text(word)
                        .customFont(.body)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                }
            }
        }
        .frame(width: 300)
        .padding(.vertical, 40)
        .background(Color.orange)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
