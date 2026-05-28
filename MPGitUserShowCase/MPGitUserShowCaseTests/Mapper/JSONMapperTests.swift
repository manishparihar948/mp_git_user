//
//  JSONMapperTests.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 28.05.26.
//

import Foundation
import XCTest
@testable import MPGitUserShowCase

class JSONMapperTests: XCTestCase {

    func test_with_valid_json_successfully_decodes() {
        XCTAssertNoThrow(
            try StaticJSONMapper
                .decode(file: "StaticUserListData",
                        type: UsersResponse.self),"Mapper shouldn't throw an error")
        let userResponse = try? StaticJSONMapper.decode(
            file: "StaticUserListData",
            type: [Users].self)
        XCTAssertNotNil(userResponse, "User response should not be nil")

        XCTAssertEqual(userResponse?.count, 30, "Expected 30 users in JSON")
        
        let firstUser = userResponse?.first
                XCTAssertEqual(firstUser?.id, 1, "First user ID should be 1")
                XCTAssertEqual(firstUser?.login, "mojombo", "First user login should be 'mojombo'")
                XCTAssertEqual(firstUser?.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
    }

    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(
            try StaticJSONMapper.decode(file: "", type: [Users].self), "An error should be thrown")
        do {
            _ = try StaticJSONMapper.decode(file: "", type: [Users].self)
        } catch {
            guard error is StaticJSONMapper.MappingError else {
                XCTFail("This is a wrong type of error for missing file")
                return
            }
        }
    }

    func test_with_invalid_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "abcd", type: [Users].self), "An error should be thrown")
        do {
            _ = try StaticJSONMapper.decode(file: "abcd", type: UsersResponse.self)
        } catch  {
            guard error is StaticJSONMapper.MappingError else {
                XCTFail("This is a wrong type of error for invalid file")
                return
            }
        }
    }
}
