//
//  Endpoint.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import Foundation

enum Endpoint {
    case user
    case detailUser(id:Int)
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    var host: String { APIConfig.environment.baseURL }

    var path : String {
        switch self {
        case .user:
            return "/users"
        case .detailUser(let id):
            return "/users/\(id)"
        }
    }

    var methodType: MethodType {
        switch self {
        case .user:
             .GET
        case .detailUser(let data):
             .GET
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
