//
//  GithubRepositable.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/03.
//

protocol GithubRepositable: AnyObject {
    func searchUsers<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel]
}
