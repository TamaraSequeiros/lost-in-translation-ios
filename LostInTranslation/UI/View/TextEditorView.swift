//
//  TextEditorView.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding private var text: String
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    var body: some View {
        TextEditor(text: $text)
            .frame(width: 300, height: 100)
            .cornerRadius(10)
        
        if text.isEmpty {
            Text("Type your description here")
                .foregroundColor(.gray)
                .padding(.horizontal, 10)
                .padding(.top, 10)
        }
    }
}
