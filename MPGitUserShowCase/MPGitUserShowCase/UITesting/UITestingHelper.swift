//
//  UITestingHelper.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 03.06.26.
//


#if DEBUG

import Foundation

struct UITestingHelper {
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("ui-testing")
    }

    static var isUserListNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-user-list-networking-success"] == "1"
    }

    static var isDetailUserNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-detail-user-networking-success"] == "1"
    }
}

#endif
