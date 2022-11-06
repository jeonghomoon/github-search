//
//  CachedImageRequester.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/06.
//

import UIKit

class CachedImageRequester: APIRequestable {
    typealias Response = UIImage?

    private let urlSession: URLSession
    private let imageCache: ImageCache

    init(
        urlSession: URLSession = .shared,
        imageCache: ImageCache = ImageCache()
    ) {
        self.urlSession = urlSession
        self.imageCache = imageCache
    }

    func perform<T: RequestConvertible>(_ request: T) async throws -> Response {
        let urlString = try request.asString()

        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURLString
        }

        if let image = imageCache.get(forKey: url as NSURL) {
            return image
        }

        let (data, _) = try await urlSession.data(from: url)
        let image = UIImage(data: data)
        imageCache.set(image, forKey: url as NSURL)
        return image
    }
}

class ImageCache {
    private let cache: NSCache<NSURL, UIImage>

    init(cache: NSCache<NSURL, UIImage> = NSCache()) {
        self.cache = cache
    }

    func get(forKey key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }

    func set(_ object: UIImage?, forKey key: NSURL) {
        guard let object = object else { return }

        cache.setObject(object, forKey: key)
    }

    func removeAllObjects() {
        cache.removeAllObjects()
    }
}
