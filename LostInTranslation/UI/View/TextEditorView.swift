//
//  TextEditorView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding private var text: String
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {  // Outer ZStack for text and placeholder
            TextEditor(text: $text)
                .frame(width: 300, height: 100)
                .cornerRadius(10)
                .onChange(of: speechRecognizer.text) { _, newValue in
                    text = newValue
                }
            
            if text.isEmpty {
                Text("Type your description here")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
            }
            
            ZStack(alignment: .bottomTrailing) {  // Inner ZStack for the mic button
                Color.clear  // Invisible background to fill the space
                    .frame(width: 300, height: 100)
                
                Button(action: {
                    if speechRecognizer.isRecording {
                        speechRecognizer.stopRecording()
                    } else {
                        speechRecognizer.startRecording()
                    }
                }) {
                    Image(systemName: speechRecognizer.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(speechRecognizer.isRecording ? .red : .blue)
                }
                .padding(8)
            }
        }
    }
}
#Preview {
    AIGameView()
}
