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

```swift
let features: [WhatsNewFeature] = [
    .init(
        version: "2.0.0",
        title: "Completely Redesigned",
        description: "Fresh look with improved navigation.",
        screenshotName: "screenshot_redesign"
    ),
    .init(
        version: "2.0.0",
        title: "Advanced Search",
        description: "Faster, context-aware results.",
        screenshotName: "screenshot_search"
    )
]
```

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
    WhatsNewView(
        coordinator: .init(
            dataSource: SampleDataSource(latestVersion: "2.0.0", features: features),
            versionStore: UserDefaultsVersionStore()
        )
    )
}
```

## API (Core)

* `WhatsNewFeature` — feature item model
* `WhatsNewDataSource` — provides features
* `WhatsNewVersionStore` — persists last seen version
* `WhatsNewCoordinator` — presentation logic (`shouldPresent`, `markLatestAsSeen()`)
* `WhatsNewView` — the UI

## License

MIT.
