//
//  SampleData.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
#Preview("Light Mode") {
    NavigationStack {
        WhatsNewView(
            coordinator: .init(
                dataSource: SampleData.dataSource,
                versionStore: UserDefaultsVersionStore()
            )
        )
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NavigationStack {
        WhatsNewView(
            coordinator: .init(
                dataSource: SampleData.dataSource,
                versionStore: UserDefaultsVersionStore()
            )
        )
    }
    .preferredColorScheme(.dark)
}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
private enum SampleData {
    static let dataSource = SampleDataSource(
        latestVersion: "2.0.0",
        features: [
            .init(
                version: "2.0.0",
                title: "Completely Redesigned",
                description: "Experience a fresh new look with improved navigation and a modern interface that makes everything easier to find.",
                screenshotName: "screenshot_redesign"
            ),
            .init(
                version: "2.0.0",
                title: "Advanced Search",
                description: "Find what you need faster with our new intelligent search that understands context and provides better results.",
                screenshotName: "screenshot_search"
            ),
            .init(
                version: "2.0.0",
                title: "Dark Mode Support",
                description: "Work comfortably at any time of day with automatic dark mode that adapts to your system preferences.",
                screenshotName: "screenshot_darkmode"
            )
        ]
    )
}
