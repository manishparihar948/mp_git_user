//
//  DetailUserModel.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 26.05.26.
//

import Foundation

// https://api.github.com/users/%7bUSER_ID

struct DetailUserResponse: Codable, Identifiable, Sendable, Equatable {

    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let userViewType: String?
    let siteAdmin: Bool

    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?

    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int

    let createdAt: String
    let updatedAt: String

}

/**
 "login": "defunkt",
 "id": 2,
 "node_id": "MDQ6VXNlcjI=",
 "avatar_url": "https://avatars.githubusercontent.com/u/2?v=4",
 "gravatar_id": "",
 "url": "https://api.github.com/users/defunkt",
 "html_url": "https://github.com/defunkt",
 "followers_url": "https://api.github.com/users/defunkt/followers",
 "following_url": "https://api.github.com/users/defunkt/following{/other_user}",
 "gists_url": "https://api.github.com/users/defunkt/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/defunkt/subscriptions",
 "organizations_url": "https://api.github.com/users/defunkt/orgs",
 "repos_url": "https://api.github.com/users/defunkt/repos",
 "events_url": "https://api.github.com/users/defunkt/events{/privacy}",
 "received_events_url": "https://api.github.com/users/defunkt/received_events",
 "type": "User",
 "user_view_type": "public",
 "site_admin": false,
 "name": "Chris Wanstrath",
 "company": null,
 "blog": "http://chriswanstrath.com/",
 "location": null,
 "email": null,
 "hireable": null,
 "bio": "🍔",
 "twitter_username": null,
 "public_repos": 107,
 "public_gists": 274,
 "followers": 22695,
 "following": 215,
 "created_at": "2007-10-20T05:24:19Z",
 "updated_at": "2025-08-08T19:18:26Z"
 */
