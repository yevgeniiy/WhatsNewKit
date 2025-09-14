//
//  SampleDataSource.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import Foundation
import SwiftUI

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
        // Return features only if `latestVersion` is strictly newer than `version`
        isVersion(latestVersion, newerThan: version) ? features : []
    }
}


@inline(__always)
private func parseSemVer(_ s: String) -> (Int, Int, Int) {
    let parts = s.split(separator: ".", omittingEmptySubsequences: false)
    let a = parts.indices.contains(0) ? Int(parts[0]) ?? 0 : 0
    let b = parts.indices.contains(1) ? Int(parts[1]) ?? 0 : 0
    let c = parts.indices.contains(2) ? Int(parts[2]) ?? 0 : 0
    return (a, b, c)
}

@inline(__always)
private func isVersion(_ a: String, newerThan b: String) -> Bool {
    let A = parseSemVer(a)
    let B = parseSemVer(b)
    return (A.0, A.1, A.2) > (B.0, B.1, B.2)
}
