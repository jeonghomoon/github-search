//
//  GithubRepository.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/07.
//

import UIKit

final class GithubRepository: GithubRepositable {
    private let urlSession: URLSession
    private let imageCache: ImageCache

    init(
        urlSession: URLSession = .shared,
        imageCache: ImageCache = ImageCache()
    ) {
        self.urlSession = urlSession
        self.imageCache = imageCache
    }

    func searchUsers<T: RequestConvertible>(
        _ request: T
    ) async throws -> [UserModel] {
        let requester = DecodedDataRequester<UserPageResponse>(
            urlSession: urlSession
        )
        let response = try await requester.perform(request)
        return response.toDomain()
    }

    func getCachedImage<T: RequestConvertible>(
        _ request: T
    ) async throws -> UIImage? {
        let requester = CachedImageRequester(
            urlSession: urlSession,
            imageCache: imageCache
        )
        let response = try await requester.perform(request)
        return response
    }
}
