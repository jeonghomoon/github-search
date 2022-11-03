//
//  SearchUsersUseCase+.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/03.
//

@testable import GithubSearch

extension SearchUsersUseCase {
    convenience init() {
        self.init(repository: MockGithubRepository())
    }
}
