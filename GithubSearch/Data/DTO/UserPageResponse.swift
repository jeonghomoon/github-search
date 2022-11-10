//
//  UserPageResponse.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/07.
//

import Domain

struct UserPageResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [UserResponse]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

extension UserPageResponse {
    func toDomain() -> [UserModel] {
        items.map { $0.toDomain() }
    }
}
