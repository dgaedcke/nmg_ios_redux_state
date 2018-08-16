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
	// this one should ONLY run if user has changed current event
	// if so, use new event key (+ entityRecs & pricesState) to reconstruct CurrentEventState
	// and return it
	
	return state
}
