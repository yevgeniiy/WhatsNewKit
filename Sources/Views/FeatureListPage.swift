//
//  FeatureListPage.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//

import SwiftUI

struct FeatureListPage: View {

    let features: [WhatsNewFeature]
    let geometry: GeometryProxy

    @State private var animatedFeatures: Set<UUID> = []

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    ForEach(features, id: \.id) { feature in
                        FeatureListItem(feature: feature)
                            .scaleEffect(animatedFeatures.contains(feature.id) ? 1 : 0.95)
                            .opacity(animatedFeatures.contains(feature.id) ? 1 : 0)
                            .onAppear {
                                if !animatedFeatures.contains(feature.id) {
                                    let idx = features.firstIndex(where: { $0.id == feature.id }) ?? 0
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(Double(idx) * 0.08)) {
                                        animatedFeatures.insert(feature.id)
                                    }
                                }
                            }
                    }
                }
                .padding(40)
                
                Color.clear.frame(height: 120)
            }
        }
        .coordinateSpace(name: "whatsnew.scroll")
    }
}

struct FeatureListItem: View {
    let feature: WhatsNewFeature

    private var listIcon: Image {
        if case let .system(name) = feature.artwork {
            return Image(systemName: name)
        } else {
            return Image(systemName: "sparkles")
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            iconView
            contentView
            Spacer(minLength: 0)
        }
        .padding(.vertical, 6)
    }
    
    private var iconView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(WhatsNewPalette.ctaBlue)
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(WhatsNewPalette.ctaBlue.opacity(0.2), lineWidth: 1)
            listIcon
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundStyle(.white)
        }
        .frame(width: 48, height: 48)
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(feature.title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.primary)
            
            if !feature.tags.isEmpty {
                tagsView
            }
            
            Text(feature.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
        }
    }
    
    private var tagsView: some View {
        HStack {
            ForEach(feature.tags, id: \.self) { tag in
                tagView(for: tag)
            }
            Spacer()
        }
    }
    
    private func tagView(for tag: FeatureTag) -> some View {
        Text(tag.displayName)
            .font(.caption).fontWeight(.medium)
            .foregroundStyle(tag == .premium ? tag.color : tag.color.opacity(0.8))
            .padding(.horizontal, 10)
            .frame(height: 24)
            .background(
                Capsule(style: .continuous)
                    .fill(tag == .premium ? tag.color.opacity(0.15) : tag.color.opacity(0.1))
            )
            .overlay(
                Capsule(style: .continuous)
                    .strokeBorder(tag == .premium ? tag.color.opacity(0.3) : tag.color.opacity(0.2), lineWidth: 1)
            )
    }
}
