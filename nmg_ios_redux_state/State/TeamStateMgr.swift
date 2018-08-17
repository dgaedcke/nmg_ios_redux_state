//
//  TeamStateMgr2.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/6/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation
import ReSwift


/*  Teams can be real teams, or Fantasy players
	this object tracks things like:
	events in which they are registered
	games in each of those events
	score for each game (additive in Fantasy)


	Note that TeamPlayHistory methods below are INCOMPLETE
	because I did not copy the FULL Game class (with gameStatus Enum) into this repo
	so many of those calculations need to be finished before this module is testable
*/

struct TeamStateMgr: StateType, Equatable {
	// dict of assetKey -> TeamPlayHistory
	// team can be a player in fantasy

	var teamHistMap = [AssetKey:TeamPlayHistory]()
}



extension TeamStateMgr {
	// public API for team details & team-score
	
	func update(assetKey:AssetKey, scoreDelta:Int, newScore:Int?) -> TeamStateMgr {
		// update (or create) team play hist
		let tph = self.teamHistMap[assetKey] ?? TeamPlayHistory(assetKey: assetKey)
		var new = self
		new.teamHistMap[assetKey] = tph.update(scoreDelta:scoreDelta, newScore:newScore)
		return new
	}
	
	// public API for game-state
	func update(game:Game) -> TeamStateMgr {
		// FIXME:  make sure game carries both scores or add 2 args
		
		let (favTeamKey, underTeamKey) = AssetKey.makeFrom(game: game)
		
		var new = self.update(assetKey: favTeamKey, scoreDelta: 0, newScore: 0)	// "game.favScore"
		new = new.update(assetKey: underTeamKey, scoreDelta: 0, newScore: 0)	// "game.underScore"
		return new
	}
	
	func bulkRefresh(games:[Game], teams:[Team]) -> TeamStateMgr {
		// build initial from full game list
		var tsm = self
		for g in games {
			// this is slow & memory wasteful; optimize later
			// its important that games come in PLAY-ORDER
			tsm = tsm.update(game: g)
		}
		return tsm
	}
}


// to support TeamPlayHistory below:

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

struct PerformanceEvent: Equatable {
	// when team/player does something good or bad
	let code:String	// touchdown, passComplete, interception
	let points:Int	// pos or neg
	var positive:Bool {
		return points > 0	// true if points is positive
	}
}

struct TeamPlayHistory: Equatable {	//
	/* one rec for each team / event combo
	keeps list of all games
	*/
	let assetKey:AssetKey	// string
	// shared object (singleton) that can read other parts of state from deep in the tree
//	fileprivate let storeLookup:StateAccessProxyProtocol = StateAccessProxy.shared
	fileprivate var currentScore:Int = 0	// always includes lastGameResult.earned(points)
	fileprivate var currentState:TeamPlayState = .waiting
	fileprivate var lastPlayResult:LastPlayResult = .prePlay
	// list of all games for each team
	// sorted into startDtTm order with last (most recent) game at bottom
	fileprivate var playHistory:[Game] = []
	// xxx is the list of things they did to win/lose points in fantasy mode
	fileprivate var performHistory:[PerformanceEvent] = []	//
	fileprivate var lastUpdateDtTm = Date()
	
	init(assetKey:AssetKey, games:[Game] = []) {
		self.assetKey = assetKey
		assert(true, "last game in games should start AFTER n-1 game")
		self.playHistory = games.sorted(by: { (g1, g2) in g1.scheduledStartDtTm < g2.scheduledStartDtTm } )
	}
	
	static func ==(lhs:TeamPlayHistory, rhs:TeamPlayHistory) -> Bool {
		return lhs.lastUpdateDtTm == rhs.lastUpdateDtTm
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
		// FIXME once we have the full Game entity (with gameState) available (as a struct)
		// return firstGame.gameState.isEnded
		return nil
	}
	
	private var lastCompletedGameIdx:Int? {
		for (i, g) in self.playHistory.reversed().enumerated() {
			if g.isOver {
				return playHistory.count - (i + 1)
			}
		}
		return nil
	}
	
	private func processStateChange(_ oldGame:Game, _ g:Game) {
		// what needs to happen when game rec has changed?
		
	}
	
	var _allowSellingIfOwned:Bool {
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
	
	func update(scoreDelta:Int, newScore:Int?) -> TeamPlayHistory {
		var new = self
		if let newScore = newScore {
			new.currentScore = newScore
		} else {
			new.currentScore += scoreDelta
		}
		return new
	}
	
	var eventKey:String {
		return assetKey.key
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
	
	// init & refresh are used by TeamStateMgr2
	mutating func refresh(games: [Game]) {
		/*  how do I know when to look at next game vs prior game to detect state
			transitions
		*/
		for g in games {
			var oldGame:Game?
			if let existIdx = self.playHistory.index(of: g) {
				oldGame = self.playHistory[existIdx]
				self.playHistory[existIdx] = g
				self.processStateChange(oldGame!, g)
				oldGame = nil
			} else {
				// new game; not previously seen
				self.playHistory.append(g)
			}
		}
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
		return _allowSellingIfOwned
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




// public API for event-state

//	func update(event:Event) {
//
//	}
//
//	func start(event:Event) {
//
//	}
//
//	func end(event:Event) {
//
//	}




