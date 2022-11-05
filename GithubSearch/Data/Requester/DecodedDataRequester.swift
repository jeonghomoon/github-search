//
//  DecodedDataRequester.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/05.
//

import Foundation

final class DecodedDataRequester<Response: Decodable>: APIRequestable {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func perform<T: RequestConvertible>(_ request: T) async throws -> Response {
        let urlString = try request.asString()

        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURLString
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        let (data, _) = try await urlSession.data(for: urlRequest)

        return try JSONDecoder().decode(Response.self, from: data)
    }
}
