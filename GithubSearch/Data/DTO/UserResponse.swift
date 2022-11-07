//
//  UserResponse.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/07.
//

struct UserResponse: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let receivedEventsUrl: String
    let type: String
    let score: Int
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let eventsUrl: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case score
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case eventsUrl = "events_url"
        case siteAdmin = "site_admin"
    }
}

extension UserResponse {
    func toDomain() -> UserModel {
        UserModel(name: login, profile: avatarUrl)
    }
}
