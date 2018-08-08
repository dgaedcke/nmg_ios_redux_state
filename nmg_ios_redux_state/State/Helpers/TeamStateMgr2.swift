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
	
	var teamIdMap = [String:TeamGameHistory]()
	
	private init() {
		//
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


struct TeamGameHistory: Equatable {
	/* one rec for each team
	keeps list of all games
	keeps pointer to next game
	rec BEFORE pointer is just finished game
	also keeps currentTeamState (wrapper for TeamStateMarker)
	*/
	let teamID:TeamID
	// list of all games for each team
	// sorted into startDtTm order
	var gameTree:[GameProgress] = []
	
	// currentTeamState is not really used for much at all;  this can be simplified
	// all its doing it setting wasEliminated & dispatching notifications
	var currentTeamState:TeamState = TeamState.seed()
	var wasEliminated:Bool = false
	
	/*  nextUnfinishedGameProgIdx was designed to track the game immediately following
	the last ended game;  sometimes it exists, sometimes it does not
	*/
	var nextUnfinishedGameProgIdx:Int?	// location of next unfinished game in gameTree
	
	// init & refresh are used by TeamStateMgr
	mutating func refresh(games: [Game]) {
		/*  how do I know when to look at next game vs prior game to detect state
		transitions
		*/
		
		let (gt, ngi) = returnGameTreeAndNextIdx(teamID:self.teamID, games:games)
		self.gameTree = gt
		self.nextUnfinishedGameProgIdx = ngi
		
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
			self.currentTeamState = self.currentTeamState.compare(newTeamStateMarker: rs)
			self.wasEliminated = rs == .NowWorthless
		}
		// broadcast any change in state
		self.currentTeamState.notify(teamID: self.teamID)
	}
	
	init(teamID:TeamID, games:[Game]) {
		self.teamID = teamID
		
		let (gt, ngi) = returnGameTreeAndNextIdx(teamID:teamID, games:games)
		self.gameTree = gt
		self.nextUnfinishedGameProgIdx = ngi
		
		if let ngi = ngi, ngi < gt.count {
			// there is a next game
			let nextGP = gt[ngi]
			self.currentTeamState = TeamState(teamState: nextGP.relatedState(teamID: teamID))
			self.wasEliminated = currentTeamState.teamState == .NowWorthless
		} // otherwise leave .NoChange
		// no change on init so not calling notify here
	}
}

extension TeamGameHistory {
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
		guard let nuf = nextUnfinishedGameProgIdx, nuf < gameTree.count else {
			return nil
		}
		return gameTree[nuf]
	}
	
	fileprivate var lastGameProgress:GameProgress? {
		/*  rename to lastUnfinishedGameProgress and use
		when last gameProg == lastCompletedGameProgress
		it would be better (faster, cleaner, more accurate) to return nil
		but that needs to be tested first
		*/
		guard gameTree.count > 0 else { return nil }
		return gameTree[gameTree.count - 1]
	}
	
	fileprivate var lastCompletedGameProgress:GameProgress? {
		// back up from end of list (most recent) until
		// you find an ended game;  should always be the last or 2nd to last entry
		for gp in self.gameTree.reversed() {
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

extension TeamGameHistory {
	// public API to TeamStateMgr  (plus init & refresh above)
	
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
		return self.gameTree.filter( {$0.game.id == id}).count > 0
	}
}

