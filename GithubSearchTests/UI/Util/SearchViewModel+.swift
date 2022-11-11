//
//  SearchViewModel+.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/08.
//

@testable import Data
@testable import GithubSearch

extension SearchViewModel {
    convenience init() {
        ImageCache().removeAllObjects()
        self.init(
            searchUsersUseCase: MockSearchUsersUseCase(),
            getCachedImageUseCase: MockGetCachedImageUseCase()
        )
    }
}
