//
//  GetCachedImageRequest+.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/07.
//

import Domain

extension GetCachedImageRequest: RequestConvertible {
    public func asString() throws -> String {
        image
    }
}
