//
//  SearchUsersUseCase.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/03.
//

public struct SearchUsersRequest {
    public let query: String
    public let page: Int

    public init(query: String, page: Int) {
        self.query = query
        self.page = page
    }
}

public protocol SearchUsersUsable: AnyObject {
    func execute<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel]
}

public final class SearchUsersUseCase: SearchUsersUsable {
    private var repository: GithubRepositable

    public init(repository: GithubRepositable) {
        self.repository = repository
    }

    public func execute<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel] {
        try await repository.searchUsers(request)
    }
}
