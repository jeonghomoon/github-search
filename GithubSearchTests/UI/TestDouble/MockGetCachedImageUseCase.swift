//
//  MockGetCachedImageUseCase.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/08.
//

@testable import Domain
@testable import GithubSearch
import UIKit

final class MockGetCachedImageUseCase: GetCachedImageUsable {
    static let successData = UIImage(systemName: "person")

    static var expectedError: Error?

    func execute<T: RequestConvertible>(_ request: T) async throws -> UIImage? {
        guard let error = Self.expectedError else {
            return Self.successData
        }

        throw error
    }
}
