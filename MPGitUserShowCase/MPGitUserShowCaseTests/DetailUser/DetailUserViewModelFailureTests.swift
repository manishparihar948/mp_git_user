//
//  DetailUserViewModelFailureTests.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 03.06.26.
//

import XCTest
@testable import MPGitUserShowCase

final class DetailUserViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: DetailUserViewModel!

    override func setUp() {
        networkingMock = NetworkManagerUserDetailsResponseFailureMock()
        vm = DetailUserViewModel(networkingManager: networkingMock)
    }

    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    @MainActor
    func test_with_unsuccessful_response_error_is_handled() async {

        XCTAssertFalse(vm.isLoading, "The view model should not be loading")

        defer {
            XCTAssertFalse(vm.isLoading, "The view model should not be loading")
        }

        await vm.fetchUserDetails(for: "octocat")

        XCTAssertTrue(vm.hasError, "The view model error should be true")

        XCTAssertNotNil(vm.error, "The view model error should not be nil")
    }

}
