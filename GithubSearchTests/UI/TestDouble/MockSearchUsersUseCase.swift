//
//  MockSearchUsersUseCase.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/08.
//

@testable import Domain
@testable import GithubSearch

final class MockSearchUsersUseCase: SearchUsersUsable {
    static let successData = [
        UserModel(
            name: "name",
            profile: "profile"
        )
    ]

    static var expectedError: Error?

    func execute<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel] {
        guard let error = Self.expectedError else {
            return Self.successData
        }

        throw error
    }
}
