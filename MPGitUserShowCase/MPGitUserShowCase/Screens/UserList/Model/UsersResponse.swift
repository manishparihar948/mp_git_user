//
//  UsersResponse.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 22.05.26.
//

import Foundation

struct Users: Codable, Identifiable, Hashable {

    let login: String
    let id: Int

    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?

    let url: String?
    let htmlURL: String?
    let followersURL: String?

    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?

    let subscriptionsURL: String?
    let organizationsURL: String?
    let reposURL: String?

    let eventsURL: String?
    let receivedEventsURL: String?

    let type: TypeEnum?
    let userViewType: UserViewType?

    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

enum UserViewType: String, Codable {
    case userViewTypePublic = "public"
}

typealias UsersResponse = [Users]
