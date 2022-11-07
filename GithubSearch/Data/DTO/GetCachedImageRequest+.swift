//
//  GetCachedImageRequest+.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/07.
//

extension GetCachedImageRequest: RequestConvertible {
    func asString() throws -> String {
        image
    }
}
