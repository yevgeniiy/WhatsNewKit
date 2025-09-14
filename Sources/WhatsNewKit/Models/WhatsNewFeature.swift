//
//  WhatsNewFeature.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import Foundation

/// A single changelog item presented on a pager page.
public struct WhatsNewFeature: Identifiable, Equatable, Sendable {
    public let id = UUID()
    public let version: String
    public let title: String
    public let description: String
    public let screenshotName: String
    
    public init(version: String, title: String, description: String, screenshotName: String) {
        self.version = version
        self.title = title
        self.description = description
        self.screenshotName = screenshotName
    }
}
