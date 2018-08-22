//
//  EventStateReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/16/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//


import ReSwift


func eventStateReducer(action: Action, state: CurrentEventState?, entityRecs:CoreEntityRepoState?, pricesState:PricesState?) -> CurrentEventState {
	//
	var state = state ?? CurrentEventState()

	if let eventAction = action as? STAct.EventEvent {
		switch eventAction {
		case .initGameTeam(let games, let teams):
			state = state.bulkUpdate(games:games, teams:teams)
		case .gameUpdated(let game):
			// current event has not changed so you only need to update team-state
			state.teamStateMgr = state.teamStateMgr.update(game: game)
		case .priceIncreased(let newPrice):
			break
		default:
			break
		}
	}
	
	if let modeAction = action as? STAct.AppMode {
		switch modeAction {
		case .changeCurrentEvent(let eventID):
			state.teamStateMgr = TeamStateMgr()
		default:
			break
		}
	}
	
	return state
}
