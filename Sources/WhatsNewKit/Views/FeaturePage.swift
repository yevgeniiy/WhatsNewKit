//
//  FeaturePage.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

/// Individual feature page displaying title, description and screenshot.
struct FeaturePage: View {
    
    // MARK: - Properties
    let feature: WhatsNewFeature
    let isLast: Bool
    let geometry: GeometryProxy

    // MARK: - State
    @State private var imageLoaded = false
    @State private var contentOffset: CGFloat = 0

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 24) {
                    screenshot
                        .offset(y: contentOffset * 0.2) // subtle parallax

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Label(feature.version, systemImage: "sparkles")
                                .font(.caption).fontWeight(.medium)
                                .foregroundStyle(WhatsNewPalette.ctaBlue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(WhatsNewPalette.ctaBlue.opacity(0.1))
                                )
                            Spacer()
                        }

                        Text(feature.title)
                            .font(.title2).fontWeight(.bold)
                            .foregroundStyle(.primary)

                        Text(feature.description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 24)

                    if isLast { 
                        Color.clear.frame(height: 120) 
                    }
                }
                .padding(.vertical, 20)
            }
        }
        .coordinateSpace(name: "whatsnew.scroll")
    }

    @ViewBuilder
    private var screenshot: some View {
        // Try to load image using SwiftUI Image initializer
        if let _ = Bundle.main.url(forResource: feature.screenshotName, withExtension: nil) {
            Image(feature.screenshotName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [Color.white.opacity(0.3), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 10)
                .scaleEffect(imageLoaded ? 1 : 0.95)
                .opacity(imageLoaded ? 1 : 0)
                .onAppear {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) { 
                        imageLoaded = true 
                    }
                }
                .frame(maxHeight: min(geometry.size.height * 0.5, 450))
                .padding(.horizontal, 24)
        } else {
            // Fallback placeholder
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.tertiary.opacity(0.2))
                .overlay(
                    VStack(spacing: 12) {
                        Image(systemName: "photo.fill").font(.system(size: 48, weight: .thin))
                            .foregroundStyle(.tertiary)
                        Text("Screenshot").font(.caption).foregroundStyle(.tertiary)
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(.separator.opacity(0.3), lineWidth: 1)
                )
                .aspectRatio(9/16, contentMode: .fit)
                .frame(maxHeight: min(geometry.size.height * 0.5, 450))
                .padding(.horizontal, 24)
        }
    }
}
