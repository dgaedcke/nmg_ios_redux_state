//
//  CoreEntityReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/6/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func coreEntityReducer(action: Action, state: CoreEntityRepo?) -> CoreEntityRepo {
	
	var state = state ?? CoreEntityRepo.shared
	guard let eventAction = action as? StEventAction
		else {
			print("wrong action type for eventReducer  \(action)")
			return state
	}
	
	switch eventAction {
	case .gameUpdated(let updatedGame):
		state.updateObj(rec: updatedGame)
	default:
		break
	}
	
	return state
}
