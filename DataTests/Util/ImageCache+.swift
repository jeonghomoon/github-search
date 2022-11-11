//
//  ImageCache+.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/06.
//

@testable import Data
@testable import GithubSearch
import Foundation

extension ImageCache {
    convenience init()  {
        self.init(cache: NSCache())
        removeAllObjects()
    }
}
