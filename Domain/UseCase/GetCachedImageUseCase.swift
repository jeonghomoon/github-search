//
//  GetCachedImageUseCase.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/04.
//

import UIKit

public struct GetCachedImageRequest {
    public let image: String

    public init(image: String) {
        self.image = image
    }
}

public protocol GetCachedImageUsable: AnyObject {
    func execute<T: RequestConvertible>(_ request: T) async throws -> UIImage?
}

public final class GetCachedImageUseCase: GetCachedImageUsable {
    private var repository: GithubRepositable

    public init(repository: GithubRepositable) {
        self.repository = repository
    }

    public func execute<T: RequestConvertible>(_ request: T) async throws -> UIImage? {
        try await repository.getCachedImage(request)
    }
}
