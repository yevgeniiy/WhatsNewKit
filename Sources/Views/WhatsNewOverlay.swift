//
//  WhatsNewOverlay.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

/// Bottom overlay containing page indicator and call-to-action button.
struct WhatsNewOverlay: View {
    
    let pageCount: Int
    let currentIndex: Int
    let scrollProgress: CGFloat
    let onComplete: () -> Void

    private var isOnLastPage: Bool { 
        scrollProgress >= CGFloat(max(0, pageCount - 1)) - 0.1
    }

    var body: some View {
        VStack(spacing: 20) {
            if pageCount > 1 {
                PageIndicator(count: pageCount, scrollProgress: scrollProgress)
                    .accessibilityHidden(true)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            if isOnLastPage {
                Button(action: onComplete) {
                    HStack {
                        Text("Get Started").font(.headline)
                        Image(systemName: "arrow.right").font(.subheadline.weight(.bold))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous).fill(WhatsNewPalette.ctaBlue)
                    )
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding(.top, pageCount > 1 ? 8 : 0)
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.85), value: isOnLastPage)
    }
}
