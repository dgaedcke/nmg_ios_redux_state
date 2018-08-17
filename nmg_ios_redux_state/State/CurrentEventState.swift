//
//  CurrentEventState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


struct CurrentEventState: StateType, Equatable {
	/*  EventID for current (user) selected event
		plus including ID's for teams, games & current team prices
	
		this is "derived" state that is reset each time the user switches events
	*/
	// vals related to current (ie user selected) event
	var eventID:RDXTypes.EventID = ""
	var relatedTeamIDs:[RDXTypes.TeamID] = []
	var relatedGameIDs:[RDXTypes.GameID] = []
	var teamPrices:[RDXTypes.TeamID:TeamPrice] = [:]

	// teamStateMgr holds state for every team (not just current event)
	var teamStateMgr:TeamStateMgr = TeamStateMgr()
	
	func bulkUpdate(games:[Game], teams:[Team]) -> CurrentEventState {
		// called when app inits
		let tsm = teamStateMgr.bulkRefresh(games:games, teams:teams)
		var new = self
		new.teamStateMgr = tsm
		return new
	}
}
