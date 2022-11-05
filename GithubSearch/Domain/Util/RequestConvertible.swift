//
//  RequestConvertible.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/03.
//

protocol RequestConvertible {
    var endpoint: String { get }

    var path: String { get }

    var method: String { get }

    func asString() throws -> String
}
