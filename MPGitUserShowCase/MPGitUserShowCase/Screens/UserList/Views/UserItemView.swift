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
            avatarImageView
                .frame(maxWidth: .infinity)
                .frame(height: 130)
                .background(Color(.systemGray6))
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(usrObj.login)
                    .foregroundStyle(.primary)
                    .font(.system(.subheadline, design: .rounded))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
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
                    ZStack {
                        Color(.systemGray6)
                        ProgressView()
                    }

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure(let error):
                    let _ = print("❌ Image failed for \(usrObj.login): \(error.localizedDescription)")
                    ZStack {
                        Color(.systemGray5)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(24)
                            .foregroundColor(.gray)
                    }

                @unknown default:
                    Color(.systemGray6)
                }
            }
        } else {
            // avatarURL was nil — show placeholder
            ZStack {
                Color(.systemGray6)
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(24)
                    .foregroundColor(.gray)
            }
        }
    }
}

