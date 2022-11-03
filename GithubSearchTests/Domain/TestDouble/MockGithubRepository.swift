//
//  MockGithubRepository.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/03.
//

@testable import GithubSearch

final class MockGithubRepository: GithubRepositable {
    static let successUsers = [
        UserModel(name: "name", profile: "profile")
    ]

    func searchUsers<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel] {
        Self.successUsers
    }
}
