//
//  FeaturePager.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

/// A paging container that displays feature pages with smooth transitions.
struct FeaturePager: View {
    
    let features: [WhatsNewFeature]
    @Binding var currentIndex: Int
    @Binding var scrollProgress: CGFloat
    
    private var pageContents: [PageContent] {
        var contents: [PageContent] = []
        var listFeatures: [WhatsNewFeature] = []
        
        // First, add all fullPage features as individual pages
        for feature in features {
            if feature.presentationType == .fullPage {
                contents.append(.fullPage(feature))
            } else {
                listFeatures.append(feature)
            }
        }
        
        // Then, add all list features as one page at the end with "What else?" header
        if !listFeatures.isEmpty {
            contents.append(.list(listFeatures))
        }
        
        return contents
    }

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $currentIndex) {
                ForEach(Array(pageContents.enumerated()), id: \.offset) { index, content in
                    Group {
                        switch content {
                        case .fullPage(let feature):
                            FeaturePage(
                                feature: feature,
                                isLast: index == pageContents.count - 1,
                                geometry: geometry
                            )
                            
                        case .list(let listFeatures):
                            FeatureListPage(
                                features: listFeatures,
                                geometry: geometry
                            )
                        }
                    }
                    .tag(index)
                }
            }
            #if os(iOS) || os(tvOS) || os(visionOS)
            .tabViewStyle(.page(indexDisplayMode: .never))
            #endif
            .onChange(of: currentIndex) { oldValue, newValue in
                // Простая анимация смены индекса
                withAnimation(.easeInOut(duration: 0.3)) {
                    scrollProgress = CGFloat(newValue)
                }
            }
        }
    }
}

private enum PageContent {
    case fullPage(WhatsNewFeature)
    case list([WhatsNewFeature])
}
