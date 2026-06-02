//
//  UserListViewModelSuccessTests.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 02.06.26.
//

import XCTest
@testable import MPGitUserShowCase

@MainActor
final class UserListViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: UserViewModel!

    override func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        vm = UserViewModel(networkingManager: networkingMock)
    }

    override func tearDown() {
        networkingMock = nil
        vm = nil
    }


    func test_with_successful_response_users_list_array_is_set() async throws {
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        await vm?.fetchGitUsersList()
        XCTAssertEqual(vm?.usersObject.count, 30, "There should be 30 users within an array")
    }

    func test_with_reset_called_values_is_reset() async throws {
        defer {
            XCTAssertEqual(vm.usersObject.count, 30, "There should be 30 users within our array")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loadingg any data")
        }
        await vm.fetchGitUsersList()
        XCTAssertEqual(vm.usersObject.count, 30, "There should be 30 users within our array")
        
    }

}
