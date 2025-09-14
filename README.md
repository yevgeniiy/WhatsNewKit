# WhatsNewKit

Show a tasteful “What’s New” screen in pure SwiftUI.

## Requirements

* iOS 17+
* Xcode 15+
* Swift 5.9+

## Installation (SPM)

```swift
dependencies: [
  .package(url: "https://github.com/yevgeniiy/WhatsNewKit.git", from: "0.1.0")
]
```

In Xcode: **File → Add Package Dependency…** → paste repo URL → add **WhatsNewKit** to your target.

## Quick Start

### 1) Import

```swift
import WhatsNewKit
```

### 2) Describe your features

Use screenshots from your app’s Asset Catalog (`assetName:`) for full-page items, or SF Symbols (`systemImage:`) for compact list items. You can also add **tags** like `.premium`, `.beta`, or a custom one.

```swift
let features: [WhatsNewFeature] = [
    // Full-page item with an app asset screenshot
    .init(
        version: "2.0.0",
        title: "Completely Redesigned",
        description: "Fresh look with improved navigation.",
        assetName: "screenshot_redesign",
        presentationType: .fullPage
    ),

    // Full-page item with a tag
    .init(
        version: "2.0.0",
        title: "Top-up Report",
        description: "Generate detailed top-up reports.",
        assetName: "screenshot_topup",
        presentationType: .fullPage,
        tags: [.premium]
    ),

    // Compact list item with an SF Symbol + Beta tag
    .init(
        version: "2.0.0",
        title: "iPad Support",
        description: "Use the app on iPad. This is a beta.",
        systemImage: "ipad",
        presentationType: .list,
        tags: [.beta]
    ),

    // List item with a custom tag
    .init(
        version: "2.0.0",
        title: "New Shortcuts",
        description: "Do more with fewer taps.",
        systemImage: "bolt.fill",
        presentationType: .list,
        tags: [.custom(name: "Pro", color: .pink)]
    )
]
```

> Screenshots should live in your **app’s** `Assets.xcassets`. Use the **image set name** (no `@2x/@3x`, no extension).
> If an asset is missing (e.g., in previews), WhatsNewKit shows a placeholder.

### 3) Create a data source & coordinator, then present

```swift
let dataSource = SampleDataSource(latestVersion: "2.0.0", features: features)
let versionStore = UserDefaultsVersionStore()

struct ContentView: View {
    @StateObject private var coordinator = WhatsNewCoordinator(
        dataSource: dataSource,
        versionStore: versionStore
    )

    var body: some View {
        YourMainView()
            .sheet(isPresented: Binding(
                get: { coordinator.shouldPresent },
                set: { showing in
                    if !showing { coordinator.markLatestAsSeen() }
                }
            )) {
                WhatsNewView(coordinator: coordinator)
            }
    }
}
```

## Customize

### Custom Data Source

```swift
struct MyDataSource: WhatsNewDataSource {
    var latestVersion: String { "2.1.0" }
    func allFeatures() -> [WhatsNewFeature] { /* ... */ }
    func features(newerThan version: String) -> [WhatsNewFeature] { /* ... */ }
}
```

### Custom Version Store

```swift
final class MyVersionStore: WhatsNewVersionStore {
    var lastSeenVersion: String {
        get { /* read */ }
        set { /* write */ }
    }
}
```

## Previews

```swift
#Preview {
    let features = [
        WhatsNewFeature(
            version: "2.0.0",
            title: "Completely Redesigned",
            description: "Fresh look with improved navigation.",
            assetName: "screenshot_redesign",
            presentationType: .fullPage,
            tags: [.custom(name: "Pro", color: .pink)]
        )
    ]

    let coordinator = WhatsNewCoordinator(
        dataSource: SampleDataSource(latestVersion: "2.0.0", features: features),
        versionStore: UserDefaultsVersionStore()
    )

    return WhatsNewView(coordinator: coordinator)
}
```

## API (Core)

* `WhatsNewFeature` — feature item model

  * `artwork`: `.asset(String)`, `.system(String)`, or `.none`
  * `presentationType`: `.fullPage` or `.list`
  * `tags`: `[FeatureTag]` (`.premium`, `.beta`, `.custom(name:color:)`)
  * convenience inits: `assetName:` / `systemImage:`
* `WhatsNewDataSource` — provides features
* `WhatsNewVersionStore` — persists last seen version (`UserDefaultsVersionStore` included)
* `WhatsNewCoordinator` — presentation logic (`shouldPresent`, `markLatestAsSeen()`)
* `WhatsNewView` — the UI

## License

MIT.
