//
//  EventStateReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/16/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//


import ReSwift


func eventStateReducer(action: Action, state: CurrentEventState?, entityRecs:CoreEntityRepo?, pricesState:PricesState?) -> CurrentEventState {
	//
	var state = state ?? CurrentEventState()

	switch action as? STAct.EventEvent {
	case .gameUpdated(let game)?:
		state.teamStateMgr = state.teamStateMgr.update(game: game)
	case .priceIncreased(let newPrice)?:
		break
	default:
		break
	}
	
	
	return state
}
