//
//  NetworkingEndpointsTest.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 28.05.26.
//

import XCTest
@testable import MPGitUserShowCase

final class NetworkingEndpointsTest: XCTestCase {

    // https://api.github.com/users
    func test_with_user_list_endpoint_request_is_valid() {
        let endpoint = Endpoint.users
        XCTAssertEqual(endpoint.host, "api.github.com", "The host should be api.github.com")
        XCTAssertEqual(endpoint.path, "/users", "The path should be /users")
        XCTAssertEqual(endpoint.methodType, .get, "The methodType should be .get")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://api.github.com/users", "The generated url should match our endpoint url")
    }

    func test_with_detail_user_request_is_valid() {
        let userId = "mojombo"
        let endpoint = Endpoint.detailUser(id: userId)

        // https://api.github.com/users/{USER_ID}
        XCTAssertEqual(endpoint.host, "api.github.com", "The host should be api.github.com")
        XCTAssertEqual(endpoint.path, "/users/\(userId)", "The path should be /users/\(userId)")
        XCTAssertEqual(endpoint.methodType, .get, "The method type should be get")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://api.github.com/users/\(userId)", "The generated url should match our endpoint url")
    }

}
