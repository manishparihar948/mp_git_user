//
//  UserScreen.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import SwiftUI

struct UserScreen: View {

    var navigator: TabNavigator

    private let columns =  Array(repeating: GridItem(.flexible()),count: 2)

    // let users = Array(1...12)
    var vm: UserViewModel

    init(navigator: TabNavigator, vm: UserViewModel) {
        self.navigator = navigator
        self.vm = vm
    }

    var body: some View {

        @Bindable var nav = navigator

        NavigationStack(path: $nav.path) {
            ZStack {
                if vm.isLoading {
                    ProgressView()
                } else {
                    galleryGridView
                }
            }
            .navigationTitle("Git User Profile")
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
    var galleryGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Array(vm.usersObject.enumerated()), id: \.element.id) { index, objImg in
                    NavigationLink(value: objImg) {
                        UserItemView(user: objImg)
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            if vm.isFetching {
                ProgressView()
            }
        }
        .navigationDestination(for: Users.self) { objImg in
            // To Do - User Detail View Screen
            EmptyView()
        }
    }
}
