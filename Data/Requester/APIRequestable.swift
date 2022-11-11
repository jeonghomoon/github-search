//
//  APIRequestable.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/05.
//

import Domain
import Foundation

protocol APIRequestable: AnyObject {
    associatedtype Response

    func perform<T: RequestConvertible>(_ request: T) async throws -> Response
}

enum RequestError: Error {
    case invalidURLString
    case emptyPath
}
