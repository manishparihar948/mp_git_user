//
//  UserListModelViewFailureTests.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 02.06.26.
//

import XCTest
@testable import MPGitUserShowCase

@MainActor
final class UserListModelViewFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: UserViewModel!

    override func setUp() {
        networkingMock = NetworkingManagerUserListResponseFailureMock()
        vm = UserViewModel(networkingManager: networkingMock)
    }

    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    func test_with_unsuccessful_response_error_is_handled() async {
        XCTAssertFalse(vm.isLoading, "The view  model shouldnt be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }

        await vm.fetchGitUsersList()

        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertNotNil(vm.error, "The view model error should be set")
    }

}
