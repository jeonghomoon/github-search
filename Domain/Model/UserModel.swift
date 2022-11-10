//
//  UserModel.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/03.
//

public struct UserModel: Equatable {
    public let name: String
    public let profile: String

    public init(name: String, profile: String) {
        self.name = name
        self.profile = profile
    }
}
