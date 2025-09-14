//
//  FeaturePager.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

/// A paging container that displays feature pages with smooth transitions.
struct FeaturePager: View {
    
    // MARK: - Properties
    let features: [WhatsNewFeature]
    @Binding var currentIndex: Int
    @Binding var scrollProgress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $currentIndex) {
                ForEach(Array(features.enumerated()), id: \.element.id) { index, feature in
                    FeaturePage(
                        feature: feature,
                        isLast: index == features.count - 1,
                        geometry: geometry
                    )
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
