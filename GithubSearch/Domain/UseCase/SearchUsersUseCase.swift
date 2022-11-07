//
//  SearchUsersUseCase.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/03.
//

struct SearchUsersRequest {
    let query: String
    let page: Int
}

protocol SearchUsersUsable: AnyObject {
    func execute<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel]
}

final class SearchUsersUseCase: SearchUsersUsable {
    private var repository: GithubRepositable

    init(repository: GithubRepositable) {
        self.repository = repository
    }

    func execute<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel] {
        try await repository.searchUsers(request)
    }
}
