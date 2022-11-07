//
//  SearchUserRequest+.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/07.
//

extension SearchUsersRequest: RequestConvertible {
    var path: String {
        "/search/users?q=\(query)&page=\(page)"
    }
}
