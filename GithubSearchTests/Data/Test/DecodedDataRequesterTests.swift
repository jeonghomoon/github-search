//
//  DecodedDataRequesterTests.swift
//  GithubSearchTests
//
//  Created by Jeongho Moon on 2022/11/05.
//

@testable import GithubSearch
import XCTest

private struct Response: Decodable {
    var foo: String
}

final class DecodedDataRequesterTests: XCTestCase {
    private var sut: DecodedDataRequester<Response>!

    override func setUp() {
        super.setUp()

        sut = DecodedDataRequester()
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    func testPerformRequest() async throws {
        let expect = "bar"

        MockURLProtocol.requestHandler = { request in
            let exampleData = "{\"foo\": \"\(expect)\",}".data(using: .utf8)!

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: "2.0",
                headerFields: nil
            )!

            return (response, exampleData)
        }

        let response = try await sut.perform(DefaultRequest())
        XCTAssertEqual(response.foo, expect)
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
}

