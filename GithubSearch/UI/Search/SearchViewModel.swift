//
//  SearchViewModel.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/08.
//

import Domain
import UIKit

final class SearchViewModel {
    @Published private(set) var items: [UserItem] = []

    private let searchUsersUseCase: SearchUsersUsable
    private let getCachedImageUseCase: GetCachedImageUsable

    private var query = ""
    private var page = 1

    private var searchUsersRequest: SearchUsersRequest {
        SearchUsersRequest(query: query, page: page)
    }

    init(
        searchUsersUseCase: SearchUsersUsable = SearchUsersUseCase(
            repository: GithubRepository()
        ),
        getCachedImageUseCase: GetCachedImageUsable = GetCachedImageUseCase(
            repository: GithubRepository()
        )
    ) {
        self.searchUsersUseCase = searchUsersUseCase
        self.getCachedImageUseCase = getCachedImageUseCase
    }

    @MainActor
    func searchUsers(_ query: String) async throws {
        self.query = query
        page = 1
        items = try await searchUsersUseCase.execute(
            searchUsersRequest
        ).fromDomain()
    }

    @MainActor
    func loadNextPage() async throws {
        page += 1
        items += try await searchUsersUseCase.execute(
            searchUsersRequest
        ).fromDomain()
    }

    @MainActor
    func fetchImage(
        in item: UserItem,
        default placeholder: UIImage?
    ) async throws {
        var item = item

        let image: UIImage?
        do {
            let request = GetCachedImageRequest(image: item.profile)
            image = try await getCachedImageUseCase.execute(request)
        } catch {
            image = placeholder
        }

        guard let index = items.firstIndex(where: { $0 == item }) else {
            return
        }

        item.profileImage = image
        items[index] = item
    }
}

