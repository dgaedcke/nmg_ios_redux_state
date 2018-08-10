//
//  EventState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift



struct EventsState: StateType, Equatable {
	/*  which events are open/available
	current games in play
	play status for a given game
	all GLOBAL data (same for all users)
	*/
	var eventMap:[String:Event] = [:]
	// class singleton
	var teamStateMgr = TeamStateMgr.shared	// replace with TeamStateMgr2 when ready
	
	private var dirtyFlag:Int = 0
	
	mutating func updateEvent(event:Event) {
		// facade over teamStateMgr
		markDirty()
		eventMap[event.id] = event
	}
	
	mutating func updateTeamState(teams:[Team], games:[Game]) {
		// facade over teamStateMgr
		markDirty()
		teamStateMgr.updateState(teams: teams, games: games)
	}
	
	mutating func updateGameState(games:[Game]) {
		markDirty()
		teamStateMgr.updateGameState(games: games)
	}
	
	func containsGame(id:String) -> Bool {
		return teamStateMgr.containsGame(id:id)
	}
	
	private mutating func markDirty() {
		self.dirtyFlag += 1
	}
	
	static func ==(lhs: EventsState, rhs: EventsState) -> Bool {
		return lhs.dirtyFlag == rhs.dirtyFlag
	}
}
