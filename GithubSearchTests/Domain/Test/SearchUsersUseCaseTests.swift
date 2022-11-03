//
//  SearchUsersUseCaseTests.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/03.
//

@testable import GithubSearch
import XCTest

final class SearchUsersUseCaseTests: XCTestCase {
    private var sut: SearchUsersUseCase!

    override func setUp() {
        super.setUp()

        sut = SearchUsersUseCase()
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    func testSearchUsersUseCase() async throws {
        // given
        let expect = MockGithubRepository.successUsers

        // when
        let request = SearchUsersRequest(query: "query", page: 1)
        let response = try await sut.execute(request)

        // then
        XCTAssertEqual(expect, response)
    }
}
