//
//  GradientView.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import SwiftUI

struct GradientView: View {
    let color: Color
    let isActive: Bool

    var body: some View {
        ZStack {
            // Gradient background
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [color.opacity(0.7), color],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    // Active border highlight
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(isActive ? Color.primary : Color.clear, lineWidth: 3)
                )

            // Optional checkmark when active
            if isActive {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white, .black.opacity(0.6))
                    .shadow(radius: 2)
            }
        }
        .frame(width: 70, height: 70) // Adjust size for grid
        .padding(4)
        .animation(.easeInOut, value: isActive)
    }
}

#Preview {
    VStack(spacing: 20) {
        GradientView(color: .blue, isActive: false)
        GradientView(color: .red, isActive: true)
    }
    .padding()
}
