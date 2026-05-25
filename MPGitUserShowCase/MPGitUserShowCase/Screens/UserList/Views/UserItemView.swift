//
//  UserItemView.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import SwiftUI

struct UserItemView: View {
    let usrObj: Users

    var body: some View {
        VStack(spacing: .zero) {
            // MARK: - Avatar Section
            avatarImageView
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .clipped()
                .overlay(alignment: .bottomTrailing) {
                    typebadge
                }

            // MARK: - Footer Section
            HStack(spacing:8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(usrObj.login)
                        .foregroundStyle(.primary)
                        .font(
                            .system(
                                .subheadline,
                                design: .rounded,
                                weight: .semibold
                            )
                        )
                        .lineLimit(1)

                    Text("@\(usrObj.login)")
                        .foregroundStyle(.secondary)
                        .font(.system(.caption2, design: .rounded))
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {                                       // ← border frame
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [.oceanDeep.opacity(0.5), .oceanMid.opacity(0.25)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
        .shadow(color: Color.oceanDeep.opacity(0.2), radius: 8, x: 0, y: 4)
    }

    // MARK: - Type Badge

    private var typebadge: some View {
        Text(usrObj.type?.rawValue ?? "User")
            .font(.system(size: 9, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(
                Capsule()
                    .fill(Color("141e30").opacity(0.75))
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 0.5)
                    }
            )
            .padding(8)
    }

    // MARK: - Avatar

    @ViewBuilder
    private var avatarImageView: some View {
        // Step 1: Build URL explicitly and log it
        let resolvedURL: URL? = {
            guard let raw = usrObj.avatarUrl, !raw.isEmpty else {
                return nil
            }
            guard let url = URL(string: raw) else {
                return nil
            }
            return url
        }()

        if let url = resolvedURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    shimmerPlaceholder
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    placeholderView

                @unknown default:
                    placeholderView
                }
            }
        } else {
            // avatarURL was nil — show placeholder
            placeholderView
        }
    }
}

// MARK: - Placeholder

private var placeholderView: some View {
    ZStack {
        LinearGradient(
            colors: [.oceanDeep, .oceanMid],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .scaledToFit()
            .padding(32)
            .foregroundStyle(.white.opacity(0.3))
    }
}

// MARK: - Shimmer Placeholder

private var shimmerPlaceholder: some View {
    ZStack {
        Color(.systemGray5)
        ProgressView()
            .tint(.gray)
    }
}
