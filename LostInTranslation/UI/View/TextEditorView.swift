//
//  TextEditorView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding private var text: String
    @StateObject private var speechViewModel = SpeechRecognitionViewModel()
    
    init(text: Binding<String>) {
        self._text = text
        
        // Configure TextEditor padding
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(width: 350, height: 220)
                .cornerRadius(10)
                .scrollDisabled(true)
                .font(.system(size: 20))
                .colorScheme(.light)
                .onChange(of: speechViewModel.text) { _, newValue in
                    text = newValue
                }
            
            if text.isEmpty {
                Text("Type your description here")
                    .font(.system(size: 20)) 
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
            }
            
            ZStack(alignment: .bottomTrailing) {  // Inner ZStack for the mic button
                Color.clear  // Invisible background to fill the space
                    .frame(width: 350, height: 220)
                
                Button(action: {
                    if speechViewModel.isRecording {
                        speechViewModel.stopRecording()
                    } else {
                        speechViewModel.startRecording()
                    }
                }) {
                    Image(systemName: speechViewModel.isRecording ? "microphone.slash" : "microphone")
                        .font(.system(size: 38))
                        .foregroundColor(speechViewModel.isRecording ? .red : .black)
                }
                .padding(8)
            }
        }
    }
    
    // Clean up when view disappears
    private static func cleanUp() {
        UITextView.appearance().textContainerInset = .zero
    }
}
#Preview {
    AIGameView()
}
