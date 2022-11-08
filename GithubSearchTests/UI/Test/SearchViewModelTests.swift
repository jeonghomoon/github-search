//
//  SearchViewModelTests.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/08.
//

@testable import GithubSearch
import Combine
import XCTest

final class SearchViewModelTests: XCTestCase {
    private var sut: SearchViewModel!
    private var cancelBag = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        cancelBag = []
        sut = SearchViewModel()
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    func testSearchUsersSuccess() async throws {
        let query = "valid"

        MockSearchUsersUseCase.expectedError = nil

        sut.$items
            .dropFirst()
            .sink{ items in
                XCTAssertEqual(
                    items.map { $0.toDomain() },
                    MockSearchUsersUseCase.successData
                )
            }.store(in: &cancelBag)

        try await sut.searchUsers(query)
    }

    func testSearchUsersFailure() async throws {
        let query = "invalid"
        let expectedError = RequestError.invalidURLString

        MockSearchUsersUseCase.expectedError = expectedError

        do {
            try await sut.searchUsers(query)
        } catch {
            XCTAssertEqual(error as? RequestError, expectedError)
        }
    }

    func testLoadNextPageSuccess() async throws {
        let query = "valid"

        MockSearchUsersUseCase.expectedError = nil

        sut.$items
            .dropFirst(2)
            .sink{ items in
                XCTAssertEqual(
                    items.map { $0.toDomain() },
                    MockSearchUsersUseCase.successData + 
                    MockSearchUsersUseCase.successData
                )
            }.store(in: &cancelBag)

        try await sut.searchUsers(query)
        try await sut.loadNextPage()
    }

    func testLoadNextPageFailure() async throws {
        let query = "invalid"
        let expectedError = RequestError.invalidURLString

        MockSearchUsersUseCase.expectedError = nil
        try await sut.searchUsers(query)
        MockSearchUsersUseCase.expectedError = expectedError

        do {
            try await sut.searchUsers(query)
        } catch {
            XCTAssertEqual(error as? RequestError, expectedError)
        }
    }

    func testFetchImageSuccess() async throws {
        let query = "valid"

        MockSearchUsersUseCase.expectedError = nil
        MockGetCachedImageUseCase.expectedError = nil

        sut.$items
            .dropFirst(2)
            .sink{ items in
                guard let item = items.first else {
                    return XCTFail()
                }
                XCTAssertEqual(
                    item.profileImage,
                    MockGetCachedImageUseCase.successData
                )
            }.store(in: &cancelBag)

        try await sut.searchUsers(query)
        guard let item = sut.items.first else {
            return XCTFail()
        }
        try await self.sut.fetchImage(in: item, default: nil)
    }

    func testFetchImageFailure() async throws {
        let query = "valid"

        MockSearchUsersUseCase.expectedError = nil
        MockGetCachedImageUseCase.expectedError = RequestError.invalidURLString

        sut.$items
            .dropFirst(2)
            .sink{ items in
                guard let item = items.first else {
                    return XCTFail()
                }
                XCTAssertEqual(item.profileImage, nil)
            }.store(in: &cancelBag)

        try await sut.searchUsers(query)
        guard let item = sut.items.first else {
            return XCTFail()
        }
        try await self.sut.fetchImage(in: item, default: nil)
    }
}
