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

    let users = Array(1...12)

    init(navigator: TabNavigator) {
        self.navigator = navigator
    }

    var body: some View {

        @Bindable var nav = navigator

        NavigationStack(path: $nav.path) {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id: \.self) { user in
                            NavigationLink(value: user) {
                                // UserItemView(user: user)
                            }
                        }
                    }
                    .navigationTitle("Git User Profile")
                    .navigationDestination(for: Users.self) { user in
                        // To Do - User Detail View Screen
                        EmptyView()
                    }
                }
            }
        }
    }
}

// Extension
private extension UserScreen {

}
