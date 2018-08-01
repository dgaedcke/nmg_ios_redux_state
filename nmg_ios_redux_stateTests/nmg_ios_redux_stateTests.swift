//
//  nmg_ios_redux_stateTests.swift
//  nmg_ios_redux_stateTests
//
//  Created by Dewey Gaedcke on 7/30/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import XCTest
@testable import nmg_ios_redux_state
import ReSwift

class nmg_ios_redux_stateTests: XCTestCase {
	
	var pendExpectation:XCTestExpectation?
//	var callbackCount = 0
	var store:Store<AppState> {
		return (UIApplication.shared.delegate as! AppDelegate).store
	}
	
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
	
	deinit {
		store.unsubscribe(self)
	}
	
    func test_changing_game_state() {
		// create & store expectation B4 subscribing
		self.pendExpectation = self.expectation(description: "test_changing_game_state")
//		print("\(self.pendExpectation?.description ?? "shit")")

		// subscription will cause state to be sent once;  dispatch (below) will cause it to get sent again
//		let store = (UIApplication.shared.delegate as! AppDelegate).store
		store.subscribe(self) { (subscription:Subscription) in
			subscription.select { (state:AppState) in
				return state.eventsState
			}
		}

		let newGame = Game(id: "123", favTeamId: "favID", underTeamId: "underID", sportId: "foot-nfl", eventId: "dgEvent", actualStartDtTm: Date() )
		let action = StEventAction.gameUpdated(newGame)
		store.dispatch(action)
//		print("end store.dispatch")
		
		waitForExpectations(timeout: 5, handler: nil)
    }
}

extension nmg_ios_redux_stateTests: StoreSubscriber {
	
	func newState(state: EventsState) {
//		callbackCount += 1
		print("got callback:  \(self.pendExpectation?.debugDescription ?? "oops?")")
		switch self.pendExpectation?.debugDescription ?? "oops?" {
		case "test_changing_game_state":
			print("case test_changing_game_state on call \(1)")
			self.pendExpectation?.fulfill()
		default:
			print("break")
			break
		}
	}
}
