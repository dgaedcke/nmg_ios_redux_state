//
//  TeamStatus.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/9/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

import Foundation

enum EventAdvanceMethod:String, Codable {
	
	case bestOfAllGames
	case singleElimination
	case doubleElimination
}

enum TeamGameCompletionStatus:Int, Codable {
	
	case roster = 0
	case scheduled
	case playing
	case won
	case lost	// no more games/matches
	case draw
	case eliminated	// no more games/matches
	case wonfinal
	
	var label:String {
		switch self {
		case .roster:  // tradable
			return "Roster"
		case .scheduled:	// tradable
			return "Scheduled"
		case .playing:
			return "Playing"
		case .won:
			return "won"
		case .lost:
			return "lost"
		case .draw:
			return "draw"
		case .eliminated:
			return "eliminated"
		case .wonfinal:
			return "Won Final"
			//		default:
			//			return "FIXME"
		}
	}
}

enum GamePlayStatus:String, Codable {
	// status in current game of tournament
	case preGame	// before / between matches
	case tradable	// open for trading
	case postponed
	case gameOn		// game started; trading closed
	case endedWin
	case endedDraw
	case future		// a game in db that would NOT be known in real event (for testing)
	
	var label:String {
		return self.rawValue	// FIXME .localized()
	}
	
	var isOver:Bool {
		return [.endedWin, .endedDraw].contains(self)
	}
	
	var isActive:Bool {
		return ![.endedWin, .endedDraw, .future].contains(self)
	}
	
	var isOpenForTrading:Bool {
		return self == .tradable
	}
	
	var isUnresolved:Bool {
		switch self {
		case .preGame, .tradable, .postponed, .gameOn:
			return true
		default:
			return false
		}
	}
	
}


enum PortfolioAssetStatus:String, Codable {
	// status in my portfolio; each user
	// this should "type" all my "holding" recs
	
	case ignore
	case offerPending	// transitory state while buy transaction pending
	case owned	// state at end of transaction
	case expired	// if team lost
	case askPending	// transitory state while transaction pending
	case sold	// state at end of game
	
	var label:String {
		return self.rawValue	// FIXME  .localized()
	}
	
	var notShown:Bool {
		return self != .owned
	}
}
