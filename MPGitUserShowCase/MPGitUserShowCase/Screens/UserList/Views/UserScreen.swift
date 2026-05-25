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
                if vm.isLoading {
                    loadingView
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

    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView("Loading users...")
                .progressViewStyle(.circular)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var galleryGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(vm.usersObject) { usrObj in
                    UserItemView(usrObj: usrObj)
                }
            }
        }
        .overlay(alignment: .bottom) {
            if vm.isFetching {
                ProgressView()
            }
        }
        //.navigationDestination(for: Users.self) { objImg in
        // To Do - User Detail View Screen
        //    EmptyView()
        //}
    }
}
