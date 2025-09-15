//
//  PreviewData.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//

import SwiftUI

public struct PreviewData {
    
    public static func createPreviewWithTags() -> SampleDataSource {
        let items: [WhatsNewFeature] = [
            // Full page with app asset and multiple tags
            .init(
                version: "2.1.0",
                title: "Redesigned Interface",
                description: "Experience our completely redesigned UI with improved navigation, better accessibility, and polished visuals.",
                assetName: "screenshot_redesign",
                presentationType: .fullPage,
                tags: [.premium, .custom(name: "New", color: .green)]
            ),

            // Full page with SF Symbol and beta tag
            .init(
                version: "2.1.0",
                title: "Smart Notifications",
                description: "Contextual alerts that adapt to your usage patterns and deliver updates at the right time.",
                systemImage: "bell.badge.fill",
                presentationType: .fullPage,
                tags: [.beta]
            ),

            // List items with various tags
            .init(
                version: "2.1.0",
                title: "Dark Mode Support",
                description: "Switch seamlessly between light and dark themes.",
                systemImage: "moon.fill",
                presentationType: .list
            ),
            .init(
                version: "2.1.0",
                title: "Improved Performance",
                description: "App launches up to 2× faster with optimized code paths.",
                systemImage: "speedometer",
                presentationType: .list,
                tags: [.premium, .custom(name: "Fast", color: .blue)]
            ),
            .init(
                version: "2.1.0",
                title: "Bug Fixes",
                description: "Resolved various issues and improved overall stability.",
                systemImage: "wrench.and.screwdriver.fill",
                presentationType: .list
            ),
            .init(
                version: "2.1.0",
                title: "AI Features",
                description: "Advanced AI-powered features for better productivity.",
                systemImage: "brain.head.profile",
                presentationType: .list,
                tags: [.custom(name: "AI", color: .purple), .beta]
            )
        ]

        return .init(latestVersion: "2.1.0", features: items)
    }
    
    public static func createPreviewCustomTags() -> SampleDataSource {
        let items: [WhatsNewFeature] = [
            .init(
                version: "2.2.0",
                title: "Custom Theme",
                description: "Create your own themes with custom colors and styles.",
                systemImage: "paintbrush.fill",
                presentationType: .fullPage,
                tags: [.custom(name: "Custom", color: .pink), .custom(name: "Theme", color: .indigo)]
            ),
            .init(
                version: "2.2.0",
                title: "Advanced Analytics",
                description: "Detailed insights into your app usage and performance.",
                systemImage: "chart.bar.fill",
                presentationType: .fullPage,
                tags: [.premium, .custom(name: "Analytics", color: .orange)]
            ),
            .init(
                version: "2.2.0",
                title: "Cloud Sync",
                description: "Seamlessly sync your data across all devices.",
                systemImage: "cloud.fill",
                presentationType: .list,
                tags: [.custom(name: "Cloud", color: .cyan)]
            )
        ]

        return .init(latestVersion: "2.2.0", features: items)
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
#Preview("Light Mode") {
    NavigationStack {
        WhatsNewView(
            coordinator: .init(
                dataSource: PreviewData.createPreviewWithTags(),
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
                dataSource: PreviewData.createPreviewWithTags(),
                versionStore: UserDefaultsVersionStore()
            )
        )
    }
    .preferredColorScheme(.dark)
}

#Preview("With Tags") {
    NavigationStack {
        WhatsNewView(
            coordinator: .init(
                dataSource: PreviewData.createPreviewWithTags(),
                versionStore: UserDefaultsVersionStore()
            )
        )
    }
    .preferredColorScheme(.light)
}

#Preview("Custom Tags") {
    NavigationStack {
        WhatsNewView(
            coordinator: .init(
                dataSource: PreviewData.createPreviewCustomTags(),
                versionStore: UserDefaultsVersionStore()
            )
        )
    }
    .preferredColorScheme(.light)
}
#endif
