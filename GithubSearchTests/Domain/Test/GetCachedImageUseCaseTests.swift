//
//  GetCachedImageUseCaseTests.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/04.
//

@testable import GithubSearch
import XCTest

final class GetCachedImageUseCaseTests: XCTestCase {
    private var sut: GetCachedImageUseCase!

    override func setUp() {
        super.setUp()

        sut = GetCachedImageUseCase()
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    func testGetCachedImageUseCase() async throws {
        // given
        let request = GetCachedImageRequest(image: "image")

        // when
        let requestedResponse = try await sut.execute(request)
        let cachedResponse = try await sut.execute(request)

        guard
            let requestedResponse = requestedResponse,
            let cachedResponse = cachedResponse
        else {
            return XCTFail()
        }

        // then
        XCTAssertEqual(requestedResponse, cachedResponse)
    }
}
