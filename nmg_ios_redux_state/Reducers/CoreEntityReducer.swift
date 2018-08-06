//
//  CoreEntityReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/6/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


func coreEntityReducer(action: Action, state: CoreEntityRepo?) -> CoreEntityRepo {
	// 
	var state = state ?? CoreEntityRepo.shared
	switch action {
	case StEventAction.gameUpdated(let updatedGame):
		state.updateObj(rec: updatedGame)
	case StEventAction.eventUpdated(let event):
		state.updateObj(rec: event)
		
//	case StEventAction.teamUpdated(let team):
//		state.updateObj(rec: team)
	default:
		break
	}
	
	return state
}
