//
//  DetailUserScreen.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 26.05.26.
//

import SwiftUI

struct DetailUserScreen: View {

    let userId: String
    var viewModel = DetailUserViewModel()

    init(userId: String) {
        self.userId = userId
    }

    var body: some View {

        ZStack {

            background

            if viewModel.isLoading {

                ProgressView()
                    .tint(.white)

            } else {

                ScrollView {

                    VStack(spacing: 24) {

                        profileHeader

                        statsSection

                        infoSection
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchUserDetails(for: userId)
        }
    }
}

private extension DetailUserScreen {

    var background: some View {
        LinearGradient(
            colors: [.oceanDeep, .oceanMid],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    // MARK: - Profile Header

    @ViewBuilder
    var profileHeader: some View {

        VStack(spacing: 16) {

            if let avatarAbsoluteString = viewModel.detailUserObject?.avatarUrl,
               let avatarUrl = URL(string: avatarAbsoluteString) {

                AsyncImage(url: avatarUrl) { image in

                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                } placeholder: {

                    ProgressView()
                        .tint(.white)
                }
                .frame(width: 140, height: 140)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.white.opacity(0.5), lineWidth: 4)
                }
                .shadow(radius: 10)
            }

            Text(viewModel.detailUserObject?.name ?? "-")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text("@\(viewModel.detailUserObject?.login ?? "")")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.gray)

            Text(viewModel.detailUserObject?.bio ?? "No Bio")
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.85))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.top)
    }

    // MARK: - Stats Section

    var statsSection: some View {

        HStack(spacing: 16) {

            statCard(
                title: "Followers",
                value: "\(viewModel.detailUserObject?.followers ?? 0)"
            )

            statCard(
                title: "Following",
                value: "\(viewModel.detailUserObject?.following ?? 0)"
            )

            statCard(
                title: "Repos",
                value: "\(viewModel.detailUserObject?.publicRepos ?? 0)"
            )
        }
    }

    // MARK: - Info Section

    var infoSection: some View {

        VStack(spacing: 16) {

            infoRow(
                title: "Type",
                value: viewModel.detailUserObject?.type ?? "-"
            )

            infoRow(
                title: "Blog",
                value: viewModel.detailUserObject?.blog ?? "-"
            )

            infoRow(
                title: "GitHub URL",
                value: viewModel.detailUserObject?.htmlUrl ?? "-"
            )

            infoRow(
                title: "Created At",
                value: viewModel.detailUserObject?.createdAt ?? "-"
            )

            infoRow(
                title: "Updated At",
                value: viewModel.detailUserObject?.updatedAt ?? "-"
            )
        }
    }

    // MARK: - Reusable Stat Card

    func statCard(title: String, value: String) -> some View {

        VStack(spacing: 8) {

            Text(value)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: - Reusable Info Row

    func infoRow(title: String, value: String) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.gray)

            Text(value)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
