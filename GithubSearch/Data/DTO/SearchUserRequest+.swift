//
//  SearchUserRequest+.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/07.
//

import Domain

extension SearchUsersRequest: RequestConvertible {
    public var path: String {
        "/search/users?q=\(query)&page=\(page)"
    }
}
