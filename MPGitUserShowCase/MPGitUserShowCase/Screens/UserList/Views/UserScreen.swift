//
//  UserScreen.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import SwiftUI

struct UserScreen: View {

    var navigator: TabNavigator
    var vm: UserViewModel

    private let columns =  Array(repeating: GridItem(.flexible()),count: 2)


    init(navigator: TabNavigator, vm: UserViewModel) {
        self.navigator = navigator
        self.vm = vm
    }

    var body: some View {

        @Bindable var nav = navigator

        NavigationStack(path: $nav.path) {
            ZStack {
                background

                if vm.isLoading {
                    loadingView
                } else {
                    galleryGridView
                }
            }
            .navigationTitle("Git User Profile")
            .toolbarColorScheme(.dark, for: .navigationBar)   // ← white title/icons on dark bg
            .toolbarBackground(Color("141e30"), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
            .task {
                await vm.fetchGitUsersList()
            }
            .alert(
                "Something went wrong",
                isPresented: .init(get: {vm.hasError}, set: {vm.hasError=$0})) {
                    Button("Retry") {
                        Task { await vm.fetchGitUsersList() }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text(vm.error?.errorDescription ?? "An unknown error occurred.")
                }
        }
    }
}

// Extension
private extension UserScreen {

    var background: some View {
        LinearGradient(
            colors: [.oceanDeep, .oceanMid],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )        .ignoresSafeArea()
    }

    @ViewBuilder
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView("Loading users...")
                .progressViewStyle(.circular)
                .tint(.white)
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder
    var galleryGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(vm.usersObject) { usrObj in
                    NavigationLink {
                        DetailUserScreen(userId: usrObj.login)
                    } label: {
                        UserItemView(usrObj: usrObj)
                            .accessibilityIdentifier("item_\(usrObj.id)")
                    }
                    .buttonStyle(.plain)    // ← removes NavigationLink blue tint on cells
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .accessibilityIdentifier("userGrid")
        }
        .overlay(alignment: .bottom) {
            if vm.isFetching {
                ProgressView().tint(.white)
            }
        }
    }
}
