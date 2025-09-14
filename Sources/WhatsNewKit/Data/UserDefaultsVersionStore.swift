//
//  UserDefaultsVersionStore.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import Foundation

public final class UserDefaultsVersionStore: WhatsNewVersionStore {
    private let key: String
    private let defaults: UserDefaults

    public init(key: String = "lastSeenVersion", defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults
        // Seed default if empty to avoid nil
        if defaults.string(forKey: key) == nil {
            defaults.set("0.0.0", forKey: key)
        }
    }

    public var lastSeenVersion: String {
        get { defaults.string(forKey: key) ?? "0.0.0" }
        set { defaults.set(newValue, forKey: key) }
    }
}
