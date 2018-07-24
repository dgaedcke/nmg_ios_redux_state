//
//  EventActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


enum StEventAction: Action {
	case eventStarted(String)
	case eventEnded(String)
	case gameStarted(String)
	case gameEnded(String)
	case tradingOpened
	case tradingClosed
	case eventPostponed
	case weatherDelay
	
}
