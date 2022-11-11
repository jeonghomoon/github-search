//
//  URLSession+.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/05.
//

import Foundation

extension URLSession {
    static let mock: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses?.insert(MockURLProtocol.self, at: 0)
        return URLSession(configuration: configuration)
    }()
}
