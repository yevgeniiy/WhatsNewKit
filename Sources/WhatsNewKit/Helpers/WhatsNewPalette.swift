//
//  WhatsNewPalette.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI
#if os(macOS)
import AppKit
#endif

// MARK: - Color Palette
enum WhatsNewPalette {
    static let ctaBlue = Color.blue
}

// MARK: - Cross-platform colors
enum WhatsNewColors {
    /// A cross-platform background color approximating the system background.
    static var systemBackground: Color {
        #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
        return Color(.systemBackground)
        #elseif os(macOS)
        return Color(nsColor: .windowBackgroundColor)
        #else
        return Color(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        #endif
    }
}
