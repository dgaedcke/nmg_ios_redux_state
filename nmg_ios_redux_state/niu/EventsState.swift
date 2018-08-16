//
//  EventState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

//
//struct EventsState: StateType, Equatable {
//	/*  which events are open/available
//	current games in play
//	play status for a given game
//	all GLOBAL data (same for all users)
//	*/
//	var eventMap:[RDXTypes.EventID:TeamStateMgr2] = [:]
//
//	
//	func updateEvent(event:Event) -> EventsState {
//		if eventMap[event.id] != nil {
//			return self
//		}
//		var new = self
//		new.eventMap[event.id] = TeamStateMgr2()
//		return new
//	}
//	
//	func updateTeam(teamID:String, scoreDelta:Int, newScore:Int?) -> EventsState {
//		
//	}
//	
//	func updateTeamState(teams:[Team], games:[Game]) {
//		// facade over teamStateMgr
//		markDirty()
//		teamStateMgr.updateState(teams: teams, games: games)
//	}
//	
//	func updateGame(games:[Game]) {
//		teamStateMgr.updateGameState(games: games)
//	}
//	
//	func containsGame(id:String) -> Bool {
//		return teamStateMgr.containsGame(id:id)
//	}
//	
//	private mutating func markDirty() {
//		self.dirtyFlag += 1
//	}
//	
//	static func ==(lhs: EventsState, rhs: EventsState) -> Bool {
//		return lhs.dirtyFlag == rhs.dirtyFlag
//	}
//}
