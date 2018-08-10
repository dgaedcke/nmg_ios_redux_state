//
//  TeamStateMgr2.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/6/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation

/*  Teams can be real teams, or Fantasy players
	this object tracks things like:
	events in which they are registered
	games in each of those events
	score for each game (additive in Fantasy)

*/

class TeamStateMgr2 {	// : Equatable
	// singleton to avoid replacing everything each time
	// team can be a player in fantasy
	static var shared = TeamStateMgr2()
	
	var teamIdMap = [String:TeamPlayHistory]()
	
	private init() {
		//
	}
	
	static func makeHistoryKeyFrom(eventID:String, teamID:String) -> String {
		return "\(teamID)-\(eventID)"
	}
	
	static func makeHistoryKeyFrom(game:Game, favTeam:Bool = true) -> String {
		let teamID = favTeam ? game.favTeamId : game.underTeamId
		return makeHistoryKeyFrom(eventID:game.eventId, teamID:teamID)
	}
}


extension TeamStateMgr2 {
	// public API for event-state
	
	func update(event:Event) {
		
	}
	
	func start(event:Event) {
		
	}
	
	func end(event:Event) {
		
	}
	
	// public API for game-state
	
	func update(game:Game) {
		
	}
	
	func start(game:Game) {
		
	}
	
	func end(game:Game) {
		
	}
	
	// public API for team-score
	func update(teamID:String, scoreDelta:Int, newScore:Int?) {
		
	}

}

enum LastPlayResult {
	case prePlay
	case won(Int)	// score
	case lost(Int)	// score
	case tied(Int)	// score
	// fantasy
	case earnedPoints(Int)	// additive points;  use 0 for no-change
	case lostPoints(Int)	// subtractive points
}

enum TeamPlayState {
	case waiting
	case scheduled(Date)	// of next game
	case playing(String, String)	// gameID, teamID
	case eliminated
}

struct PerformanceEvent {
	// when team/player does something good or bad
	let code:String	// touchdown, passComplete, interception
	let points:Int	// pos or neg
	var positive:Bool {
		return points > 0	// true if points is positive
	}
}

struct TeamPlayHistory {	// Equatable
	/* one rec for each team / event combo
	keeps list of all games
	*/
	let eventID:TeamID	// string
	let teamID:TeamID
	// shared object (singleton) that can read other parts of state from deep in the tree
	fileprivate let storeLookup:StateAccessProxyProtocol = StateAccessProxy.shared
	fileprivate var currentScore:Int = 0	// always includes lastGameResult.earned(points)
	fileprivate var currentState:TeamPlayState = .waiting
	fileprivate var lastPlayResult:LastPlayResult = .prePlay
	// list of all games for each team
	// sorted into startDtTm order with last (most recent) game at bottom
	fileprivate var playHistory:[Game] = []
	fileprivate var performHistory:[PerformanceEvent] = []	//
	
	init(eventID:TeamID, teamID:TeamID, games:[Game] = []) {
		self.eventID = eventID
		self.teamID = teamID
		assert(true, "last game should start AFTER n-1 game")
		self.playHistory = games.sorted(by: { (g1, g2) in g1.scheduledStartDtTm < g2.scheduledStartDtTm } )
	}
}

extension TeamPlayHistory {
	/* fileprivate API
	
	If not eliminated in any prior games:
	
	1) team is Liquidatable if:
	they won last game AND
	their NEXT game (last in list) either:
	a) does not exist yet;  OR b) has not yet entered Tradable state
	
	2) team is tradable if:
	their next game IS IN Tradable state
	*/
	
	private var firstCompletedGameIdx:Int? {
		guard playHistory.count > 0 else { return nil }
		
		let firstGame = playHistory[0]
		if false {	// firstGame.gameState.isEnded {
			return 0
		} else {
			return nil
		}
	}
	
	private var lastCompletedGameIdx:Int? {
		for (i, g) in self.playHistory.reversed().enumerated() {
			if g.isOver {
				return playHistory.count - (i + 1)
			}
		}
		return nil
	}
	
//	var nextUnfinishedGameProgress:GameProgress? {
//		guard let nuf = nextUnfinishedGameProgIdx, nuf < playHistory.count else {
//			return nil
//		}
//		return playHistory[nuf]
//	}
//
//	fileprivate var lastGameProgress:GameProgress? {
//		/*  rename to lastUnfinishedGameProgress and use
//		when last gameProg == lastCompletedGameProgress
//		it would be better (faster, cleaner, more accurate) to return nil
//		but that needs to be tested first
//		*/
//		guard playHistory.count > 0 else { return nil }
//		return playHistory[playHistory.count - 1]
//	}
//
//	fileprivate var lastCompletedGameProgress:GameProgress? {
//		// back up from end of list (most recent) until
//		// you find an ended game;  should always be the last or 2nd to last entry
//		for gp in self.playHistory.reversed() {
//			if gp.isOver {
//				return gp
//			}
//		}
//		return nil
//	}
	
	var _allowLiquidationSale:Bool {
		/*  Liquidation Sale:
		Sell orders that occur AFTER the first game
		and BEFORE the next Game is set to tradable
		SHOULD ONLY decrement the pool and not decrement/effect
		the winners share price
		(or if there is no next game)
		ONLY check this method for internal isTradable test
		*/
		
		guard let lcgp = lastCompletedGame
			// , lcgp.didWin(teamID: self.teamID)
			else { return false}
		
		guard let nextGame = nextScheduledGame else {
			// no next game yet; so yes, they can liquidate
			return true
		}
		return true	// nextGame.game.gameStatus == .preGame
	}
	
//	fileprivate var isCurrentlyPlaying:Bool {
//		guard let ngp = self.lastGameProgress else { return false }
//		return ngp.playInProgress
//	}
}

extension TeamPlayHistory {
	// public API (plus init & refresh above)
	
	var key:String {
		return TeamStateMgr2.makeHistoryKeyFrom(eventID: eventID, teamID: teamID)
	}
	
	var lastCompletedGame:Game? {
		if let lcgi = lastCompletedGameIdx {
			return playHistory[lcgi]
		}
		return nil
	}
	
	var nextScheduledGame:Game? {
		// aka UNCOMPLETED game
		guard let lcgi = lastCompletedGameIdx, lcgi < playHistory.count - 1
		else {	// game at end of list is completed
			return nil
		}
		return playHistory[lcgi + 1]
	}
	
	var lastScheduledGame:Game? {
		// aka UNCOMPLETED game
		guard let lcgi = lastCompletedGameIdx, lcgi < playHistory.count - 1
			else {	// game at end of list is completed
				return nil
		}
		return playHistory[playHistory.count-1]
	}
	
	var wasEliminated:Bool {
		if let lcg = lastCompletedGame {
			return false
		}
		return true	// lcg.wasEliminated
	}
	
	// init & refresh are used by TeamStateMgr
	func refresh(games: [Game]) {
		/*  how do I know when to look at next game vs prior game to detect state
			transitions
		*/
		
	}
	
	
	var isTradable:Bool {
		/*  firstGameCompleted && not isCurrentlyPlaying
		or
		firstGame is tradable
		*/
		if isEliminated {
			return false
		}
		
		if let ng = nextScheduledGame {
			return true // fixme
		} else {
			return false
		}
	}
	
	var allowLiquidationSale:Bool {
		// ONLY check this method when SELLING
		// only called right before placing the order
		return _allowLiquidationSale
	}
	
	var isEliminated:Bool {
		return self.wasEliminated
	}
	
	var lastGameState:GamePlayStatus {
		if let lastGP = self.nextScheduledGame {
			return .preGame		// lastGP.game.gameStatus
		} else {
			return .preGame
		}
	}
	
	func containsGame(id:String) -> Bool {
		return self.playHistory.filter( {$0.id == id}).count > 0
	}
}

