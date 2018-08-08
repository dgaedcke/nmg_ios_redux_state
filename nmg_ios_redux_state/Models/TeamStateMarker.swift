//
//  TeamStateChangeMarker.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 3/13/18.
//  Copyright © 2018 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

import Foundation

enum TeamStateMarker:Int, Codable, Equatable {
	case NoChange		// same state as before
	case NowTradable	// not playing
	case NowClosed	// not tradable
	case NowLiquidatable	// team won
	case NowWorthless	// team lost
	
	func notify(teamID:String) {
		// dispatch notification of team state changes
		switch self {
		case .NoChange:
			break
		default:
			break
//			NotificationEvent.teamTradeStateChanged.post(userInfo: ["marker": self, "teamID": teamID])
//		case .NowTradable:
//			break
//		case .NowClosed:
//			break
//		case .NowLiquidatable:
//			break
//		case .NowWorthless:
//			break
		}
	}
	
//	func stateLabel() -> String {
//		// label for trade button
//		var label = Strings.preGame.localized()
//		switch self {
//		case .NowTradable:
//			label = Strings.tradable.localized()
//		case .NowClosed:
//			label = Strings.gameOn.localized()
//		case .NowLiquidatable:
//			label = Strings.liquidate.localized()
//		case .NowWorthless:
//			label = Strings.eliminated.localized()
//		default:
//			break
//		}
//		return label
//	}
}
