//
//  DecodedDataRequester+.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/05.
//

@testable import GithubSearch

extension DecodedDataRequester {
    convenience init() {
        self.init(urlSession: .mock)
    }
}
