//
//  MainScreen.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 25.05.26.
//

import SwiftUI

struct MainScreen: View {
    @State private var coordinator = MainCoordinator()
    @State private var userListsNavigator = TabNavigator()
    @State private var settingsNavigator = TabNavigator()
    @State private var userViewModel : UserViewModel = {
#if DEBUG
        if UITestingHelper.isUITesting {
            let mock: NetworkingManagerImpl = UITestingHelper.isUserListNetworkingSuccessful
                ? NetworkingManagerUserResponseSuccessMock()
                : NetworkingManagerUserListResponseFailureMock()
            return UserViewModel(networkingManager: mock)
        }
#endif
        return UserViewModel()
    }()

    var body: some View {
        @Bindable var coordinator = coordinator

        TabView(selection: $coordinator.selectedTab) {
            Tab("Users", systemImage: "person.fill", value: AppTab.userscreen) {
                UserScreen(
                    navigator: userListsNavigator,
                    vm: userViewModel
                )
            }

            Tab("Settings", systemImage: "gearshape.fill", value: AppTab.setting) {
                SettingView()
            }
        }
        .environment(coordinator)
    }
}

#Preview {
    MainScreen()
}
