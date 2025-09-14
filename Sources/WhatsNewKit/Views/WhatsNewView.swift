//
//  WhatsNewView.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

public struct WhatsNewView: View {
    
    // MARK: - Dependencies
    @ObservedObject private var coordinator: WhatsNewCoordinator
    
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    // MARK: - State
    @State private var currentPageIndex: Int = 0
    @State private var pageProgress: CGFloat = 0

    public init(coordinator: WhatsNewCoordinator) {
        self.coordinator = coordinator
    }

    private var isLastPage: Bool { 
        currentPageIndex == max(0, coordinator.features.count - 1) 
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
                                pageCount: coordinator.features.count,
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

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(action: completeAndDismiss) {
                Image(systemName: "xmark").font(.body.weight(.semibold))
            }
            .accessibilityLabel("Close")
            .animation(nil, value: isLastPage)
        }
        ToolbarItem(placement: .confirmationAction) {
            ZStack {
                Text("Skip").opacity(isLastPage ? 0 : 1)
                Text("Done").opacity(isLastPage ? 1 : 0)
            }
            .frame(minWidth: 56)
            .contentShape(Rectangle())
            .onTapGesture { completeAndDismiss() }
            .animation(nil, value: isLastPage)
        }
    }

    // MARK: - Actions
    private func completeAndDismiss() {
        coordinator.markLatestAsSeen()
        dismiss()
    }
}
