//
//  FeaturePage.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

struct FeaturePage: View {
    let feature: WhatsNewFeature
    let isLast: Bool
    let geometry: GeometryProxy

    @State private var imageLoaded = false
    @State private var contentOffset: CGFloat = 0
    
    @Environment(\.colorScheme) private var colorScheme


    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 24) {
                    screenshot
                        .offset(y: contentOffset * 0.2)

                    // meta + texts
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Label(feature.version, systemImage: "sparkles")
                                .font(.caption).fontWeight(.medium)
                                .foregroundStyle(WhatsNewPalette.ctaBlue)
                                .padding(.horizontal, 12)
                                .frame(height: 28)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(WhatsNewPalette.ctaBlue.opacity(0.12))
                                )
                                .overlay(
                                    Capsule(style: .continuous)
                                        .strokeBorder(WhatsNewPalette.ctaBlue.opacity(0.25), lineWidth: 1)
                                )
                            
                            ForEach(feature.tags, id: \.self) { tag in
                                Text(tag.displayName)
                                    .font(.caption).fontWeight(.medium)
                                    .foregroundStyle(tag == .premium ? tag.color : tag.color.opacity(0.8))
                                    .padding(.horizontal, 12)
                                    .frame(height: 28)
                                    .background(
                                        Capsule(style: .continuous)
                                            .fill(tag == .premium ? tag.color.opacity(0.15) : tag.color.opacity(0.1))
                                    )
                                    .overlay(
                                        Capsule(style: .continuous)
                                            .strokeBorder(tag == .premium ? tag.color.opacity(0.3) : tag.color.opacity(0.2), lineWidth: 1)
                                    )
                            }
                            
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

                    if isLast { Color.clear.frame(height: 120) }
                }
                .padding(.vertical, 20)
            }
        }
        .coordinateSpace(name: "whatsnew.scroll")
    }

    @ViewBuilder
    private var screenshot: some View {
        // caps
        let padding: CGFloat = 24
        let capH: CGFloat = min(geometry.size.height * 0.5, 450)
        let availW: CGFloat = geometry.size.width - padding * 2

        switch feature.artwork {
        case .asset(let name):
            if let loaded = loadAppAsset(name) {
                let aspect = max(loaded.size.width, 1) / max(loaded.size.height, 1)
                let baseW = capH * aspect
                let finalH = baseW > availW ? (availW / aspect) : capH
                let finalW = finalH * aspect

                loaded.image
                    .resizable()
                    .interpolation(.high)
                    .frame(width: finalW, height: finalH)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(
                            colorScheme == .dark ? Color.white.opacity(0.14) : Color.black.opacity(0.10),
                            lineWidth: 0.75
                        )
                )

                    .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
                    .scaleEffect(imageLoaded ? 1 : 0.95)
                    .opacity(imageLoaded ? 1 : 0)
                    .onAppear {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) { imageLoaded = true }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, padding)
            } else {
                placeholderView(capH: capH, availW: availW, padding: padding)
            }

        case .system(let symbol):
            let finalH = capH
            let finalW = min(availW, finalH * (9.0/16.0))
            Image(systemName: symbol)
                .font(.system(size: min(finalW, finalH) * 0.4, weight: .semibold))
                .foregroundStyle(WhatsNewPalette.ctaBlue)
                .frame(width: finalW, height: finalH)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, padding)

        case .none:
            placeholderView(capH: capH, availW: availW, padding: padding)
        }
    }

    private func placeholderView(capH: CGFloat, availW: CGFloat, padding: CGFloat) -> some View {
        let aspect: CGFloat = 9.0/16.0
        let baseW = capH * aspect
        let finalH = baseW > availW ? (availW / aspect) : capH
        let finalW = finalH * aspect

        return RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.tertiary.opacity(0.2))
            .overlay(
                VStack(spacing: 12) {
                    Image(systemName: "photo.fill")
                        .font(.system(size: 48, weight: .thin))
                        .foregroundStyle(.tertiary)
                    Text("Screenshot")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(
                        colorScheme == .dark ? Color.white.opacity(0.14) : Color.black.opacity(0.10),
                        lineWidth: 0.75
                    )
            )
            .frame(width: finalW, height: finalH)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, padding)
    }
}

#if canImport(UIKit)
private func loadAppAsset(_ name: String) -> (image: Image, size: CGSize)? {
    guard let ui = UIImage(named: name) else { return nil }
    return (Image(uiImage: ui), ui.size) // UIImage.size = points (already / scale)
}
#elseif canImport(AppKit)
private func loadAppAsset(_ name: String) -> (image: Image, size: CGSize)? {
    guard let ns = NSImage(named: NSImage.Name(name)) else { return nil }
    return (Image(nsImage: ns), ns.size)
}
#endif
