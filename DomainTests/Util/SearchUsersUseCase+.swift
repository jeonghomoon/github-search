//
//  SearchUsersUseCase+.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/03.
//

@testable import Domain

extension SearchUsersUseCase {
    convenience init() {
        self.init(repository: MockGithubRepository())
    }
}
