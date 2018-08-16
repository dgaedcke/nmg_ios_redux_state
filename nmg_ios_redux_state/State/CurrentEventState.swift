//
//  CurrentEventState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


struct CurrentEventState: StateType, Equatable {
	/*  id for current selected event
		including teams & games & current team prices
		simply used to filter other lists from EntityRepo
	*/
	var eventID:RDXTypes.EventID = ""
	var relatedTeamIDs:[RDXTypes.TeamID] = []
	var relatedGameIDs:[RDXTypes.GameID] = []
	var teamPrices:[RDXTypes.TeamID:TeamPrice] = [:]

}
