//
//  FakeGetCachedImageRequest.swift
//  DomainTests
//
//  Created by Jeongho Moon on 2022/11/10.
//

@testable import Domain

struct FakeGetCachedImageRequest: RequestConvertible {
    var image: String

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
