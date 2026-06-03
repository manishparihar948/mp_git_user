//
//  UserListScreenUITests.swift
//  MPGitUserShowCaseUITests
//
//  Created by Manish Parihar on 03.06.26.
//

import XCTest

final class UserListScreenUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-user-list-networking-success":"1"]
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func test_grid_has_correct_number_of_items_when_screen_loads() {
        let  grid = app.otherElements["userGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "The people lazygrid should be visibile")

        let  predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let  gridItems = grid.buttons.containing(predicate)
        XCTAssertEqual(gridItems.count, 12, "There should be 12 items on the screen")

        XCTAssertTrue(gridItems.staticTexts["mojombo"].exists)
    }
}
