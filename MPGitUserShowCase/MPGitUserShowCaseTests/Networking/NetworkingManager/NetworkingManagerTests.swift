//
//  NetworkingManagerTests.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 28.05.26.
//

import XCTest
@testable import MPGitUserShowCase

// Dummy type for endpoints that return no body
struct EmptyResponse: Codable {}

final class NetworkingManagerTests: XCTestCase {
    private var session: URLSession!
    private var url: URL!

    override func setUp() {
        url = URL(string: "https://api.github.com/users")
        /**
         emphemeral  :
         No persistent storage: Unlike .default, it does not write cookies, cache, or credentials to disk.
         In-memory only: Any data (like cookies or caches) is kept only in memory while the session is alive. Once the session is invalidated or your app terminates, that data is gone.
         */
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDown() {
        session = nil
        url = nil
    }

    func test_with_successful_response_response_is_valid() async throws {
        // Get JSON
        guard let path = Bundle.main.path(forResource: "StaticUserListData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path)else {
            XCTFail("Fail to get the static user file")
            return
        }

        // Create  and set response
        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse.init(
                url: self.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)
            return  (response!, data)
        }

        let res = try await NetworkingManager.shared.authorizedRequest(
            session: session,
            .users,
            type: [Users].self
        )

        let staticJSON = try await StaticJSONMapper.decode(
            file: "StaticUserListData",
            type: [Users].self)
        XCTAssertEqual(res, staticJSON, "The return response should be decoded properly")
        XCTAssertNotNil(res, "Response should not be nil")
        XCTAssertEqual(res.count, 30, "Expected 10 users in the response")
        //XCTAssertEqual(res.first?.login,"mojombo","First user should be mojombo")
    }

    func test_with_successful_response_void_is_valid() async throws {
        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            return (response!, nil)
        }

       _ = try await NetworkingManager.shared.authorizedRequest(
            session: session,
            .users)
    }

    func test_with_unsuccessful_response_code_is_invalid_range_is_invalid() async throws {
        let invalidStatusCode = 400
        // Arrange: set up mock response with failure status code
        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,   // replace with your test URL
                statusCode: invalidStatusCode, // Bad Request
                httpVersion: nil,
                headerFields: nil
            )
            return (response!, nil)
        }

        // Act & Assert
        do {
            _ = try await NetworkingManager.shared
                .authorizedRequest(
                    session: session,
                    .users,
                    type: [Users].self
                )
            XCTFail("Expected NetworkingManager.NetworkingError.invalidStatusCode but got success")
        } catch  {
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager.NetworkingError")
                return
            }

            XCTAssertEqual(networkingError, NetworkingManager.NetworkingError .invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
        }
    }

    func test_with_unsuccesful_response_code_void_in_invalid_range_is_invalid() async {
        let invalidStatusCode = 400

        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: invalidStatusCode,
                httpVersion: nil,
                headerFields: nil
            )
            return (response!, nil)
        }

        do {
            _ = try await NetworkingManager.shared.authorizedRequest(session: session, .users)
        } catch  {
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }

            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
        }
    }

    /*
    func test_with_successful_response_with_invalid_json_is_invalid() async {
        // Get JSON
        guard let path = Bundle.main.path(forResource: "StaticUserListData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Fail to get the static user file")
            return
        }

        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            return (response!, nil)
        }

        do {
            _ = try await NetworkingManager.shared
                .authorizedRequest(
                    session: session,
                    .users,
                    type: DetailUserResponse.self
                )
        } catch {
            if error is NetworkingManager.NetworkingError {
                XCTFail("The error should be a system decoding error")
            }
        }
    }
     */
}
