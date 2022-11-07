//
//  RequestConvertible+.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/05.
//

import Foundation

extension RequestConvertible {
    var endpoint: String {
        "https://api.github.com"
    }
    
    var method: String {
        "GET"
    }
    
    var path: String {
        ""
    }

    func asString() throws -> String {
        guard !path.isEmpty else {
            throw RequestError.emptyPath
        }

        return endpoint + path
    }
}
