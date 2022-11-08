//
//  UserItem.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/08.
//

import UIKit

struct UserItem: Equatable {
    let name: String
    let profile: String
    var profileImage: UIImage?
}

extension UserItem {
    func toDomain() -> UserModel {
        UserModel(name: name, profile: profile)
    }
}

extension UserModel {
    func fromDomain() -> UserItem {
        UserItem(name: name, profile: profile, profileImage: nil)
    }
}

extension Array where Element == UserModel {
    func fromDomain() -> [UserItem] {
        self.map { $0.fromDomain() }
    } 
}
