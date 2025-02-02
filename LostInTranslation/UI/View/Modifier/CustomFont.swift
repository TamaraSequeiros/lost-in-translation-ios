//
//  Untitled.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//

import SwiftUI

enum FontStyle {
    case title
    case body
}

struct CustomFont: ViewModifier {
    let style: FontStyle
    
    func body(content: Content) -> some View {
        switch style {
        case .title:
            return content
                .font(.system(size: 30, weight: .bold, design: .rounded))
        case .body:
            return content
                .font(.system(size: 24, weight: .regular, design: .rounded))
        }
    }

}

extension View {
    func customFont(_ style: FontStyle) -> some View {
        self.modifier(CustomFont(style: style))
    }
}
