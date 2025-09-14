//
//  PageIndicator.swift
//  WhatsNewKit
//
//  Created by Yevgenii Kryzhanivskyi on 14/9/25.
//


import SwiftUI

/// A simple and elegant page indicator with capsule dots.
struct PageIndicator: View {
    
    let count: Int
    let scrollProgress: CGFloat

    private let spacing: CGFloat = 8
    private let height: CGFloat = 8
    private let dotWidth: CGFloat = 8
    private let barWidth: CGFloat = 28

    var body: some View {
        if count <= 0 { 
            EmptyView() 
        } else {
            let currentIndex = Int(round(scrollProgress))
            
            HStack(spacing: spacing) {
                ForEach(0..<count, id: \.self) { index in
                    Capsule()
                        .fill(index == currentIndex ? WhatsNewPalette.ctaBlue : Color.secondary.opacity(0.3))
                        .frame(
                            width: index == currentIndex ? barWidth : dotWidth, 
                            height: height
                        )
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(
                Capsule(style: .continuous)
                    .fill(.thinMaterial)
            )
            .animation(.easeInOut(duration: 0.3), value: currentIndex)
        }
    }
}
