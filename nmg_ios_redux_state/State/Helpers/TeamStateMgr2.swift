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

struct TeamStateMgr2 {	// : Equatable
	// singleton to avoid replacing everything each time
	static let shared = TeamStateMgr2()
	
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
	
	mutating func update(event:Event) {
		
	}
	
	mutating func start(event:Event) {
		
	}
	
	mutating func end(event:Event) {
		
	}
	
	// public API for game-state
	
	mutating func update(game:Game) {
		
	}
	
	mutating func start(game:Game) {
		
	}
	
	mutating func end(game:Game) {
		
	}
	
	// public API for team-score
	mutating func update(teamID:String, scoreDelta:Int, newScore:Int?) {
		
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

struct TeamPlayHistory {	// Equatable
	/* one rec for each team / event combo
	keeps list of all games
	*/
	let eventID:TeamID	// string
	let teamID:TeamID
	// shared object that can read other parts of state from deep in the tree
	let storeLookup:StateAccessProxyProtocol = StateAccessProxy.shared
	var currentScore:Int = 0	// always includes lastGameResult.earned(points)
	var currentState:TeamPlayState = .waiting
	var lastPlayResult:LastPlayResult = .prePlay
	// list of all games for each team
	// sorted into startDtTm order with last (most recent) game at bottom
	var playHistory:[GameProgress] = []
	
	init(eventID:TeamID, teamID:TeamID, games:[Game]) {
		self.eventID = eventID
		self.teamID = teamID
		
		let (gt, ngi) = returnGameTreeAndNextIdx(teamID:teamID, games:games)
		self.playHistory = gt
		
		if let ngi = ngi, ngi < gt.count {
			// there is a next game
			let nextGP = gt[ngi]
			self.currentState = .waiting
		} // otherwise leave .NoChange
		// no change on init so not calling notify here
	}
	
	var key:String {
		return TeamStateMgr2.makeHistoryKeyFrom(eventID: eventID, teamID: teamID)
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
	
	var nextUnfinishedGameProgress:GameProgress? {
		guard let nuf = nextUnfinishedGameProgIdx, nuf < playHistory.count else {
			return nil
		}
		return playHistory[nuf]
	}
	
	fileprivate var lastGameProgress:GameProgress? {
		/*  rename to lastUnfinishedGameProgress and use
		when last gameProg == lastCompletedGameProgress
		it would be better (faster, cleaner, more accurate) to return nil
		but that needs to be tested first
		*/
		guard playHistory.count > 0 else { return nil }
		return playHistory[playHistory.count - 1]
	}
	
	fileprivate var lastCompletedGameProgress:GameProgress? {
		// back up from end of list (most recent) until
		// you find an ended game;  should always be the last or 2nd to last entry
		for gp in self.playHistory.reversed() {
			if gp.isOver {
				return gp
			}
		}
		return nil
	}
	
	var _allowLiquidationSale:Bool {
		/*  Liquidation Sale:
		Sell orders that occur AFTER the first game
		and BEFORE the next Game is set to tradable
		SHOULD ONLY decrement the pool and not decrement/effect
		the winners share price
		(or if there is no next game)
		ONLY check this method for internal isTradable test
		*/
		
		guard let lcgp = lastCompletedGameProgress
			, lcgp.didWin(teamID: self.teamID)
			else { return false}
		
		guard let nextGame = nextUnfinishedGameProgress else {
			// no next game yet; so yes, they can liquidate
			return true
		}
		return true	// nextGame.game.gameStatus == .preGame
	}
	
	fileprivate var isCurrentlyPlaying:Bool {
		guard let ngp = self.lastGameProgress else { return false }
		return ngp.playInProgress
	}
}

extension TeamPlayHistory {
	// public API (plus init & refresh above)
	
	var nextScheduledGame:Game? {
		return lastCompletedGame
	}
	
	var lastCompletedGame:Game? {
		for g in self.playHistory.reversed() {
			if g.isOver {
				return g.game
			}
		}
		return nil
	}
	
	var wasEliminated:Bool {
		if let lcg = lastCompletedGame {
			return false
		}
		return true
	}
	
	/*  nextUnfinishedGameProgIdx was designed to track the game immediately following
	the last ended game;  sometimes it exists, sometimes it does not
	*/
	var nextUnfinishedGameProgIdx:Int? {
		// // location of next unfinished game in gameTree
		return 0
	}
	
	// init & refresh are used by TeamStateMgr
	mutating func refresh(games: [Game]) {
		/*  how do I know when to look at next game vs prior game to detect state
		transitions
		*/
		
		let (gt, ngi) = returnGameTreeAndNextIdx(teamID:self.teamID, games:games)
		self.playHistory = gt
//		self.nextUnfinishedGameProgIdx = ngi
		
		if let idx = ngi, gt.count > 0 && idx != gt.count - 1 {
			// there are games but the next unstarted one is NOT the last one
			// major red flag to this logic
			print("ERR:  \(teamID) has games after next game!!")
		}
		
		if self.wasEliminated {
			// no need to track this team any more
			return
		}
		
		if let nextGP = self.lastGameProgress {
			let rs = nextGP.relatedState(teamID: teamID)
//			self.currentState = self.currentState.compare(newTeamStateMarker: rs)
		}
		// broadcast any change in state
//		self.currentState.notify(teamID: self.teamID)
	}
	
	
	var isTradable:Bool {
		/*  firstGameCompleted && not isCurrentlyPlaying
		or
		firstGame is tradable
		*/
		if isEliminated {
			return false
		}
		
		if let ng = nextUnfinishedGameProgress {
			return ng.isTradable
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
		if let lastGP = self.lastGameProgress {
			return .preGame		// lastGP.game.gameStatus
		} else {
			return .preGame
		}
	}
	
	func containsGame(id:String) -> Bool {
		return self.playHistory.filter( {$0.game.id == id}).count > 0
	}
}

