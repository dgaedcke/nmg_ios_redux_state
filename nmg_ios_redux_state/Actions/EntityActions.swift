//
//  EventActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


enum StEntityAction: Action {
	// API updates
	case eventUpdated(Event)
	case gameUpdated(Game)
	case teamUpdated(Team)
//	case eventPostponed
//	case weatherDelay
	
	// from reducer
	case eventStarted(String)
	case eventEnded(String)
	case gameStarted(String)
	case gameEnded(String)
	case tradingOpened
	case tradingClosed

	
}
