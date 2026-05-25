//
//  UsersResponse.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 22.05.26.
//

import Foundation

struct Users: Codable, Identifiable, Hashable, Sendable {

    let login: String
        let id: Int
        let nodeId: String?
        let avatarUrl: String?      // ✅ lowercase 'l' — matches convertFromSnakeCase
        let gravatarId: String?
        let url: String?
        let htmlUrl: String?
        let followersUrl: String?
        let followingUrl: String?
        let gistsUrl: String?
        let starredUrl: String?
        let subscriptionsUrl: String?
        let organizationsUrl: String?
        let reposUrl: String?
        let eventsUrl: String?
        let receivedEventsUrl: String?
        let type: TypeEnum?
        let userViewType: UserViewType?
        let siteAdmin: Bool?
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

enum UserViewType: String, Codable {
    case userViewTypePublic = "public"
}

typealias UsersResponse = [Users]
