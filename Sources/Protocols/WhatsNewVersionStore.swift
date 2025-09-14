//
//  WhatsNewVersionStore.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import Foundation

/// Persists/reads the last seen version for the user.
public protocol WhatsNewVersionStore: AnyObject {
    var lastSeenVersion: String { get set }
}
