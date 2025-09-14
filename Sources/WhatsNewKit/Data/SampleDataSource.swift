//
//  SampleDataSource.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import Foundation

public struct SampleDataSource: WhatsNewDataSource, Sendable {
    public let latestVersion: String
    private let features: [WhatsNewFeature]

    public init(latestVersion: String, features: [WhatsNewFeature]) {
        self.latestVersion = latestVersion
        self.features = features
    }

    public func allFeatures() -> [WhatsNewFeature] { 
        features 
    }

    public func features(newerThan version: String) -> [WhatsNewFeature] {
        // Simplified comparison: string-based; replace with semantic versioning if needed.
        version < latestVersion ? features : []
    }
}
