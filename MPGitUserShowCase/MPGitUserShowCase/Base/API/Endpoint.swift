//
//  Endpoint.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import Foundation

enum Endpoint: Sendable {
    case users
    case detailUser(id:Int)
}

extension Endpoint {
    enum MethodType: Equatable, Sendable {
        case get
    }
}

extension Endpoint {
    var host: String { APIConfig.environment.baseURL }

    var path : String {
        switch self {
        case .users:
            return "/users"
        case .detailUser(let id):
            return "/users/\(id)"
        }
    }

    var methodType: MethodType {
        switch self {
        case .users:
             .get
        case .detailUser(let data):
             .get
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        return urlComponents.url
    }
}
