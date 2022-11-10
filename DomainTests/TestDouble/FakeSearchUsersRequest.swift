//
//  FakeSearchUsersRequest.swift
//  DomainTests
//
//  Created by Jeongho Moon on 2022/11/10.
//

@testable import Domain

struct FakeSearchUsersRequest: RequestConvertible {
    var query: String
    var page: Int

    public var endpoint: String {
        ""
    }

    public var method: String {
        ""
    }

    public var path: String {
        ""
    }

    public func asString() throws -> String {
        ""
    }
}
