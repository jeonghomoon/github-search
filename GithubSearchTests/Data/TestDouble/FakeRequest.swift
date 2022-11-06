//
//  FakeRequest.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/06.
//

@testable import GithubSearch

struct DefaultRequest: RequestConvertible {
    let path: String = "/valid"
}

struct InvalidRequest: RequestConvertible {
    let path: String = "/invalid%"
}

struct EmptyPathRequest: RequestConvertible {
}
