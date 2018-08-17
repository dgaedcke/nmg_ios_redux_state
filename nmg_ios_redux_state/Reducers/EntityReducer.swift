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
	var state = state ?? CoreEntityRepo()
	
	if let eventAction = action as? STAct.EventEvent {
		switch eventAction {
		case .gameUpdated(let updatedGame):
			state = state.updateObj(rec: updatedGame)
		
		case .eventUpdated(let event):
			state = state.updateObj(rec: event)
			
		case .teamUpdated(let team):
			state = state.updateObj(rec: team)
			
		default:
			break
		}
	}
	
	
	
	return state
}
