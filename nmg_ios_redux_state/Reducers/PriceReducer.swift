//
//  PriceReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func priceReducer(action: Action, state: PricesState?) -> PricesState {
	
	var state = state ?? PricesState()
	
	guard let specAction = action as? STAct.EventEvent
	else { return state }
	
	switch specAction {
	case .priceChanged(let tp):
//		state = state.updateTeamIn(eventID: "", teamPrice: tp)
		break
	case .priceDecreased(let tp):
		break
	default:
		break
	}
	
	return state
}
