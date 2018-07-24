//
//  EventReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func eventReducer(action: Action, state: EventState?) -> EventState {

	let state = state ?? EventState()
	
	switch action {
//	case let newCurrency as CurrencyModeChangeAction:
//		break
	default:
		break
	}
	
	return state
}
