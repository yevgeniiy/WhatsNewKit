//
//  WhatsNewView.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

public struct WhatsNewView: View {
    
    @ObservedObject private var coordinator: WhatsNewCoordinator
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @State private var currentPageIndex: Int = 0
    @State private var pageProgress: CGFloat = 0

    public init(coordinator: WhatsNewCoordinator) {
        self.coordinator = coordinator
    }

    private var totalPages: Int {
        let fullPageFeatures = coordinator.features.filter { $0.presentationType == .fullPage }
        let listFeatures = coordinator.features.filter { $0.presentationType == .list }
        return fullPageFeatures.count + (listFeatures.isEmpty ? 0 : 1)
    }
    
    private var isLastPage: Bool { 
        currentPageIndex == max(0, totalPages - 1) 
    }

    public var body: some View {
        NavigationStack {
            Group {
                if coordinator.features.isEmpty {
                    EmptyView()
                } else {
                    GeometryReader { geo in
                        ZStack(alignment: .bottom) {
                            // Feature pages
                            FeaturePager(
                                features: coordinator.features, 
                                currentIndex: $currentPageIndex,
                                scrollProgress: $pageProgress
                            )

                            // Overlay: indicator + CTA button
                            WhatsNewOverlay(
                                pageCount: totalPages,
                                currentIndex: currentPageIndex,
                                scrollProgress: pageProgress,
                                onComplete: completeAndDismiss
                            )
                            .padding(.horizontal, 20)
                            .padding(.bottom, geo.safeAreaInsets.bottom + 14)
                            .background(alignment: .bottom) {
                                LinearGradient(
                                    colors: [
                                        Color.clear,
                                        WhatsNewColors.systemBackground.opacity(colorScheme == .dark ? 0.55 : 0.8)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .ignoresSafeArea(edges: .bottom)
                            }
                        }
                        .background(WhatsNewColors.systemBackground)
                    }
                    #if os(iOS) || os(tvOS) || os(visionOS)
                    .statusBarHidden(false)
                    .navigationBarTitleDisplayMode(.inline)
                    #endif
                    .navigationTitle("What's New")
                    .toolbar { toolbar }
                }
            }
        }
    }

    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(action: completeAndDismiss) {
                Text(isLastPage ? "Done" : "Skip")
            }
            .accessibilityLabel("Close")
            .animation(nil, value: isLastPage)
        }
    }
    
    private func completeAndDismiss() {
        coordinator.markLatestAsSeen()
        dismiss()
    }
}
