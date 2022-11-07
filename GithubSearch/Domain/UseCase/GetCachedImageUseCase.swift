//
//  GetCachedImageUseCase.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/04.
//

import UIKit

struct GetCachedImageRequest {
    let image: String
}

protocol GetCachedImageUsable: AnyObject {
    func execute<T: RequestConvertible>(_ request: T) async throws -> UIImage?
}

final class GetCachedImageUseCase: GetCachedImageUsable {
    private var repository: GithubRepositable

    init(repository: GithubRepositable) {
        self.repository = repository
    }

    func execute<T: RequestConvertible>(_ request: T) async throws -> UIImage? {
        try await repository.getCachedImage(request)
    }
}
