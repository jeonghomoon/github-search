//
//  CachedImageRequesterTests.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/06.
//

@testable import Domain
@testable import GithubSearch
import XCTest

final class CachedImageRequesterTests: XCTestCase {
    var sut: CachedImageRequester!
    var cache: ImageCache!

    override func setUp() {
        super.setUp()

        cache = ImageCache()
        sut = CachedImageRequester(urlSession: .mock, imageCache: cache)
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
        cache = nil
    }

    func testPerformRequest() async throws {
        initSuccessRequest()

        let request = DefaultRequest()

        guard try checkCahcedImage(with: request) == nil else {
            return XCTFail()
        }

        let _ = try await sut.perform(request)

        guard let cachedImage = try checkCahcedImage(with: request) else {
            return XCTFail()
        }

        let cachedResponse = try await sut.perform(DefaultRequest())

        XCTAssertEqual(cachedImage, cachedResponse)
    }

    func testPerformRequestWhenCached() async throws {
        initSuccessRequest()

        let requestedResponse = try await sut.perform(DefaultRequest())
        let cachedResponse = try await sut.perform(DefaultRequest())

        guard
            let requestedResponse = requestedResponse,
            let cachedResponse = cachedResponse
        else {
            return XCTFail()
        }

        XCTAssertEqual(requestedResponse, cachedResponse)
    }

    func testDecodingError() async throws {
        MockURLProtocol.requestHandler = { request in
            let exampleData = "invalidData".data(using: .utf8)!

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: "2.0",
                headerFields: nil
            )!

            return (response, exampleData)
        }

        do {
            let _ = try await sut.perform(DefaultRequest())
        } catch {
            guard let _ = error as? DecodingError else {
                return XCTFail()
            }

            XCTAssert(true)
        }
    }

    func testInvalidURLStringError() async throws {
        do {
            let _ = try await sut.perform(InvalidRequest())
        } catch {
            XCTAssertEqual(error as? RequestError, .invalidURLString)
        }
    }

    func testEmptyPathError() async throws {
        do {
            let _ = try await sut.perform(EmptyPathRequest())
        } catch {
            XCTAssertEqual(error as? RequestError, .emptyPath)
        }
    }

    private func initSuccessRequest() {
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
    }

    private func checkCahcedImage(
        with request: RequestConvertible
    ) throws -> UIImage? {
        let urlString = try request.asString()

        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURLString
        }

        return cache.get(forKey: url as NSURL)
    }
}
