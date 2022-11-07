//
//  GithubRepositoryTests.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/07.
//

@testable import GithubSearch
import XCTest

final class GithubRepositoryTests: XCTestCase {
    var sut: GithubRepository!
    var cache: ImageCache!

    override func setUp() {
        super.setUp()

        sut = GithubRepository(urlSession: .mock)
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    func testUsersRequest() async throws {
        let expect = UserPageResponse(
            totalCount: 1,
            incompleteResults: true,
            items: [
                UserResponse(
                    login: "login",
                    id: 0,
                    nodeId: "nodeId",
                    avatarUrl: "avatarUrl",
                    gravatarId: "gravatarId",
                    url: "url",
                    htmlUrl: "htmlUrl",
                    followersUrl: "followersUrl",
                    subscriptionsUrl: "subscriptionsUrl",
                    organizationsUrl: "organizationsUrl",
                    reposUrl: "reposUrl",
                    receivedEventsUrl: "receivedEventsUrl",
                    type: "type",
                    score: 0,
                    followingUrl: "followingUrl",
                    gistsUrl: "gistsUrl",
                    starredUrl: "starredUrl",
                    eventsUrl: "eventsUrl",
                    siteAdmin: false
                )
            ]
        )

        MockURLProtocol.requestHandler = { request in
            let exampleData = try JSONEncoder().encode(expect)

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: "2.0",
                headerFields: nil
            )!

            return (response, exampleData)
        }

        let request = SearchUsersRequest(query: "query", page: 1)
        let response = try await sut.searchUsers(request)

        XCTAssertEqual(expect.toDomain(), response)
    }

    func testCachedImageRequest() async throws {
        MockURLProtocol.requestHandler = { request in
            let exampleData = UIImage(systemName: "person")!.pngData()!

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: "2.0",
                headerFields: nil
            )!

            return (response, exampleData)
        }

        let request = GetCachedImageRequest(image: "image")

        let requestedResponse = try await sut.getCachedImage(request)
        let cachedResponse = try await sut.getCachedImage(request)

        guard
            let requestedResponse = requestedResponse,
            let cachedResponse = cachedResponse
        else {
            return XCTFail()
        }

        XCTAssertEqual(requestedResponse, cachedResponse)
    }
}
