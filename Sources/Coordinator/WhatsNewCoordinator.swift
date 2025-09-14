//
//  WhatsNewCoordinator.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

/// Exposes presentation state and actions for the Whats New flow.
@MainActor
public final class WhatsNewCoordinator: ObservableObject {
    // Input dependencies
    private let dataSource: WhatsNewDataSource
    private let versionStore: any WhatsNewVersionStore

    // Output state
    @Published public private(set) var shouldPresent: Bool = false
    @Published public private(set) var features: [WhatsNewFeature] = []

    public init(dataSource: WhatsNewDataSource, versionStore: any WhatsNewVersionStore) {
        self.dataSource = dataSource
        self.versionStore = versionStore
        refresh()        
    }

    /// Re-evaluate which features should be shown based on last seen version.
    public func refresh() {
        let items = dataSource.features(newerThan: versionStore.lastSeenVersion)
        self.features = items
        self.shouldPresent = !items.isEmpty
    }

    /// Mark the current latest version as seen and clear the list.
    public func markLatestAsSeen() {
        versionStore.lastSeenVersion = dataSource.latestVersion
        self.features = []
        self.shouldPresent = false
    }

    /// Force showing all features (useful for QA / debug / previews).
    public func forceShowAll() {
        self.features = dataSource.allFeatures()
        self.shouldPresent = !features.isEmpty
    }
}
