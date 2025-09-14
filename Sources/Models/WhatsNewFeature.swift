//
//  WhatsNewFeature.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import Foundation
import SwiftUI

public enum FeaturePresentationType: Sendable, Equatable {
    case fullPage
    case list
}

public enum FeatureArtwork: Sendable, Equatable {
    case asset(String)
    case system(String)  // SF Symbol
    case none
}

public enum FeatureTag: Sendable, Equatable, Hashable {
    case premium
    case beta
    case custom(name: String, color: Color)
    
    public var displayName: String {
        switch self {
        case .premium:
            return "Premium"
        case .beta:
            return "Beta"
        case .custom(let name, _):
            return name
        }
    }
    
    public var color: Color {
        switch self {
        case .premium:
            return Color(red: 0.9, green: 0.6, blue: 0.1) // золотистый
        case .beta:
            return Color.purple
        case .custom(_, let color):
            return color
        }
    }
}

public struct WhatsNewFeature: Identifiable, Equatable, Sendable {
    public let id = UUID()
    public let version: String
    public let title: String
    public let description: String
    public let artwork: FeatureArtwork
    public let presentationType: FeaturePresentationType
    public let tags: [FeatureTag]

    public init(
        version: String,
        title: String,
        description: String,
        artwork: FeatureArtwork = .none,
        presentationType: FeaturePresentationType = .fullPage,
        tags: [FeatureTag] = []
    ) {
        self.version = version
        self.title = title
        self.description = description
        self.artwork = artwork
        self.presentationType = presentationType
        self.tags = tags
    }
    

    // Convenience
    public init(version: String, title: String, description: String, assetName: String, presentationType: FeaturePresentationType = .fullPage, tags: [FeatureTag] = []) {
        self.init(version: version, title: title, description: description, artwork: .asset(assetName), presentationType: presentationType, tags: tags)
    }
    public init(version: String, title: String, description: String, systemImage: String, presentationType: FeaturePresentationType = .list, tags: [FeatureTag] = []) {
        self.init(version: version, title: title, description: description, artwork: .system(systemImage), presentationType: presentationType, tags: tags)
    }
    
    
}
