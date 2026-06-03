//
//  DetailUserViewModelSuccessTests.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 03.06.26.
//

import XCTest
@testable import MPGitUserShowCase

final class DetailUserViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: DetailUserViewModel!

    override func setUp() {
        networkingMock = NetworkManagerUserDetailsResponseSuccessMock()
        vm = DetailUserViewModel(networkingManager: networkingMock)
    }

    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    @MainActor
    func test_with_successful_response_users_details_is_set() async throws {
        XCTAssertFalse(vm.isLoading, "The view model should not be loading")

        defer {
            XCTAssertFalse(vm.isLoading, "The view model should not be loading")
        }
        await vm.fetchUserDetails(for: "octocat")

        XCTAssertNotNil(vm.detailUserObject, "The user info in the view model should not be nil")

        let userDetailsData = try StaticJSONMapper.decode(
            file: "SingleUserData",
            type: DetailUserResponse.self)

        XCTAssertEqual(vm.detailUserObject?.id, userDetailsData.id)
        XCTAssertEqual(vm.detailUserObject?.login, userDetailsData.login)

        XCTAssertEqual(vm.detailUserObject, userDetailsData, "The response from our networking mock should match")
    }

}
