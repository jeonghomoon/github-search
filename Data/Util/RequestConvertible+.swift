//
//  RequestConvertible+.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/05.
//

import Domain
import Foundation

extension RequestConvertible {
    public var endpoint: String {
        "https://api.github.com"
    }

    public var method: String {
        "GET"
    }

    public var path: String {
        ""
    }

    public func asString() throws -> String {
        guard !path.isEmpty else {
            throw RequestError.emptyPath
        }

        return endpoint + path
    }
}
