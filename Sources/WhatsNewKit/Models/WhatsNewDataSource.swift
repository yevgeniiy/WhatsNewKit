//
//  WhatsNewDataSource.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import Foundation

/// Provides features and version info for the Whats New flow.
public protocol WhatsNewDataSource {
    /// The latest app version represented in the data source.
    var latestVersion: String { get }
    /// Returns all features (optionally used for previews).
    func allFeatures() -> [WhatsNewFeature]
    /// Returns features newer than a given version string.
    func features(newerThan version: String) -> [WhatsNewFeature]
}
