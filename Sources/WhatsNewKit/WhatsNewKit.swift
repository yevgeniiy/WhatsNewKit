// The Swift Programming Language
// https://docs.swift.org/swift-book


// MARK: - Example Usage
/*
 
 import SwiftWhatsKit
 
 // Create a data source with your features
 let dataSource = SampleDataSource(
        latestVersion: "2.0.0",
        features: [
         WhatsNewFeature(
                version: "2.0.0",
             title: "New Feature",
             description: "Description of your new feature",
             screenshotName: "screenshot_name"
         )
     ]
 )
 
 // Create a version store to track user's last seen version
 let versionStore = UserDefaultsVersionStore()
 
 // Create coordinator to manage the presentation logic
 let coordinator = WhatsNewCoordinator(
     dataSource: dataSource,
     versionStore: versionStore
 )
 
 // Present the WhatsNew view
 WhatsNewView(coordinator: coordinator)
     .sheet(isPresented: $coordinator.shouldPresent) {
         WhatsNewView(coordinator: coordinator)
     }
 
 */
