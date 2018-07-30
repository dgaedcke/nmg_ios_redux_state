//
//  nmg_ios_redux_stateTests.swift
//  nmg_ios_redux_stateTests
//
//  Created by Dewey Gaedcke on 7/30/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//


import XCTest
@testable import nmg_ios_redux_state

class nmg_ios_redux_stateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
		
		// add base state to start
		// run methods below to alter state
		// wait for async code to complete
		// validate that state is now as it should be
    }

//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
	
    func test_changing_game_state() {
		let expectation = self.expectation(description: "Scaling")

		expectation.fulfill()
		
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertEqual("", "")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
	
}
