//
//  APIConfig.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import Foundation

enum EnvironmentForAPI {
    case development
    case staging
    case production

    //  https://api.github.com/users
    // https://api.github.com/users/{USER_ID}
    var baseURL: String {
        switch self {
        case .development: return "api.github.com"
        case .staging: return "staging.api.github.com"
        case .production: return "api.github.com"
        }
    }
}

struct APIConfig {
    #if DEBUG
    static let environment: EnvironmentForAPI = .development
    #else
    static let environment: EnvironmentForAPI = .production
    #endif
}
