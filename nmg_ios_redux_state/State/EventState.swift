//
//  EventState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift



struct EventState: StateType {
	/*  which events are open/available
	current games in play
	play status for a given game
	all GLOBAL data (same for all users)
	*/
	var eventMap:[String:Event] = [:]
	var teamStateMgr = TeamStateMgr.shared
	
	mutating func updateEvent(event:Event) {
		// facade over teamStateMgr
		eventMap[event.id] = event
	}
	
	mutating func updateTeamState(teams:[Team], games:[Game]) {
		// facade over teamStateMgr
		teamStateMgr.updateState(teams: teams, games: games)
	}
}
