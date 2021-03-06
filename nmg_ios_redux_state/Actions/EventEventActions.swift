//
//  EventEventActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


struct STAct {
	// Any change in state of an event/tournament  (games, prices, points, start, end, etc)
	
	enum EventEvent: Action {
		// app launch (init setup)
		case initGameTeam([Game], [Team])
		
		// API updates
		case eventUpdated(Event)
		case gameUpdated(Game)
		case teamUpdated(Team)
		case priceChanged(TeamPrice)
		//	case eventPostponed
		//	case weatherDelay
		
		// from reducer
		case eventStarted(String)
		case eventEnded(String)
		case gameStarted(String)
		case gameEnded(String)
		case tradingOpened
		case tradingClosed
		
		case scoreUpdated()
		
		// from reducer
		case priceIncreased(TeamPrice)	// assetKey
		case priceDecreased(TeamPrice) // assetKey
		case priceToZero(AssetKey)	// teamID (spans many events when team loses/eliminated)
		
	}
}
