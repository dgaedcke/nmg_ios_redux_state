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

struct TestConst {
	static let SPORT_LEAGUE_ID = "foot-nfl"
	
}

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
		
		// subscription will cause state to be sent 1st time
		// dispatch (in tests below) will cause it to get sent again
		store.subscribe(self) { (subscription:Subscription) in
			subscription.select { (state:AppState) in
				return state.entityRecs
			}
		}
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		store.unsubscribe(self)
    }
	
//	deinit {
//		store.unsubscribe(self)
//	}
	
    func test_changing_game_state() {
		// create & store expectation B4 subscribing
		self.pendExpectation = self.expectation(description: "test_changing_game_state")
//		print("\(self.pendExpectation?.description ?? "shit")")



		let newGame = Game(id: "123", favTeamId: "100", underTeamId: "200", sportId: TestConst.SPORT_LEAGUE_ID, eventId: "dgEvent", actualStartDtTm: Date() )
		let action = STAct.EventEvent.gameUpdated(newGame)
		store.dispatch(action)
//		print("end store.dispatch")
		
		waitForExpectations(timeout: 5, handler: nil)
    }
	
	func test_adding_teams() {
		self.pendExpectation = self.expectation(description: "test_adding_teams")
		
		let teams = makeTeams(count: 4)
		for t in teams {
			let action = STAct.EventEvent.teamUpdated(t)
			// each time you dispatch, we get one state-callback
			store.dispatch(action)
		}
		waitForExpectations(timeout: 5, handler: nil)
	}
}

extension nmg_ios_redux_stateTests: StoreSubscriber {
	
	func newState(state: CoreEntityRepo) {
//		callbackCount += 1
		print("got callback:  \(self.pendExpectation?.debugDescription ?? "oops?")")
		switch self.pendExpectation?.debugDescription ?? "oops?" {
		case "test_changing_game_state":
			print("case test_changing_game_state on call \(1)")
			if let _:Game = state.getLatest(id: "123") {
				self.pendExpectation?.fulfill()
			}

		case "test_adding_teams":
			// called once for each action
			let teams:[Team] = store.listByType()
			if teams.count == 4 {
				let filteredTeams = teams.filter( { $0.id == "000"} )
				XCTAssert(filteredTeams.count == 1, "missing a team")
				self.pendExpectation?.fulfill()
				XCTAssert(teams.count == 4, "Team count \(teams.count) (should be 4)")
			}
			
		default:
			print("break")
			break
		}
		// unsubscribe after each test callback
		// wrong because first callback is empty state
//		store.unsubscribe(self)
	}
}


func makeTeams(count:Int = 5) -> [Team] {
	var teams = [Team]()
	for i in 0..<count {
		let name = "Team-\(i)00"
		let nt = Team(id: "\(i)00", name: name, shortName: "T-\(i)00", homeTownId: name, sportId: TestConst.SPORT_LEAGUE_ID)
		teams.append(nt)
	}
	return teams
}

