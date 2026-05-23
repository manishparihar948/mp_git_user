//
//  MainCoordinator.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import SwiftUI

// MARK: - AppTab Definition
enum AppTab: Hashable, CaseIterable {
    case userscreen
}

@Observable
final class TabNavigator {
    var path = NavigationPath()

    func push(_ value: some Hashable) {
        path.append(value)
    }

    func  popToRoot() {
        path.removeLast(path.count)
    }
}

@Observable
final class MainCoordinator {
    var  selectedTab: AppTab = .userscreen

    func switchTab(to tab: AppTab) {
        selectedTab = tab
    }
}
