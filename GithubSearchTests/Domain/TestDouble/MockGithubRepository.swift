//
//  MockGithubRepository.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/03.
//

@testable import GithubSearch
import UIKit

final class MockGithubRepository: GithubRepositable {
    static let successUsers = [
        UserModel(name: "name", profile: "profile")
    ]

    private var cachedImage: UIImage? = nil

    func searchUsers<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel] {
        Self.successUsers
    }

    func getCachedImage<T: RequestConvertible>(
        _ request: T
    ) async throws -> UIImage? {
        if cachedImage == nil {
            cachedImage = UIImage(systemName: "person")
        }
        return cachedImage
    }
}
