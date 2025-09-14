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
    
    // Tag colors
    static let premiumTag = Color(red: 0.9, green: 0.6, blue: 0.1) // золотистый
    static let betaTag = Color.purple
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

@inline(__always)
func imageForArtwork(_ a: FeatureArtwork) -> Image? {
    switch a {
    case .system(let name):
        return Image(systemName: name)

    case .asset(let name):
        #if canImport(UIKit)
        if let ui = UIImage(named: name) { return Image(uiImage: ui) }
        #elseif canImport(AppKit)
        if let ns = NSImage(named: NSImage.Name(name)) { return Image(nsImage: ns) }
        #endif
        return nil

    case .none:
        return nil
    }
}
