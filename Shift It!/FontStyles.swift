//
//  FontStyles.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import Foundation
import SwiftUI

extension Font {
    static var titleText: Font {
        return .system(size: 24, weight: .bold, design: .rounded)
    }
    static var strongText: Font {
        return .system(size: 24, weight: .semibold, design: .rounded)
    }
    static var day: Font {
        return .system(size: 16, weight: .semibold, design: .rounded)
    }
    static var popup: Font {
        return .system(size: 16, weight: .regular, design: .rounded)
    }
    static var subtitle: Font {
        return .system(size: 12, weight: .regular, design: .rounded)
    }
    static var smallText: Font {
        return .system(size: 12, weight: .semibold, design: .rounded)
    }
    
    static var iconText: Font {
        return .system(size: 24, weight: .regular, design: .default)
    }
    static var time: Font {
        return .system(size: 12, weight: .regular, design: .rounded)
    }
}


struct UppercaseModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subtitle)  // Apply the custom font
            .textCase(.uppercase)  // Transform text to uppercase
    }
}

extension View {
    func uppercaseStyle() -> some View {
        self.modifier(UppercaseModifier())
    }
}
