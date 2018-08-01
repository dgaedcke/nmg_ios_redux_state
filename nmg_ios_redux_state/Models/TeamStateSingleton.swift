//
//  TeamStateSingleton.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 3/13/18.
//  Copyright © 2018 New Millennial Games, LLC. All rights reserved.

/*
	keeps track of Game/Team state
	should also dispatch notifications when tradability changes for a team

team is tradable under following conditions:
	1) game in which they are scheduled is marked tradable
2) they WON previous game and next game is either:
	missing OR NOT YET tradable (this is the liquidation sale scenario)
those are the only two conditions!!!

TeamStateMgr is the only public access point thru:
	updateState() -> nil
	isTradable() -> Bool

Notifications (only upon state change) should be:
TeamIsTradable
TeamIsClosed
TeamIsLiquidatable (sell in quiet period)
TeamIsWorthless

GameProgress (private) is just a wrapper around the game record
TeamGameTree (private) is a teamID & list of GameProgress
TeamStateMgr is the singleton that keeps track of all this state
*/

// PSEUDOCODE .. don't copy into project

import Foundation
//import Disk
//import ExtraKit

typealias TeamID = String

private struct GameProgress: Equatable {
	/* one game being played by a team
		we only interrogate the just finished
		or about to start game to decide what is allowed
		for a given team
	*/
	let game:Game
	var isOver:Bool {
		return game.isOver
	}
	
	var isTradable:Bool {
		return false 	// game.gameStatus.isOpenForTrading
	}
	
	var playInProgress:Bool {
		return true		// game.gameStatus == .gameOn
	}
	
	func didWin(teamID:TeamID) -> Bool {
		return isOver && game.winnerTeamId == teamID
	}
	
	func relatedState(teamID: TeamID) -> TeamStateChangeMarker {
		// need to run this on last completed game
		if isOver {
			if didWin(teamID: teamID) {
				return .NowLiquidatable
			} else {
				return .NowWorthless
			}
		} else if playInProgress {
			return .NowClosed
		} else if isTradable {
			return .NowTradable
		} else {
			return .NoChange
		}
	}
}

private struct TeamState:Codable, Equatable {
	// wrapper for TeamStateMarker enum
	// and any other team state we need to track
	// STRUCT replaced each time teamstate changes
	
	let teamState:TeamStateChangeMarker
	
	func compare(newTeamStateMarker:TeamStateChangeMarker) -> TeamState {
		// self is priorTeamState
		// take new state from a GameProgress
		// and return a new instance of TeamState
		if newTeamStateMarker == self.teamState {
			return TeamState(teamState: .NoChange)
		}
		return TeamState(teamState: newTeamStateMarker)
	}
	
	func notify(teamID:TeamID) {
		self.teamState.notify(teamID: teamID)
	}
	
	static func seed() -> TeamState {
		return TeamState(teamState: .NoChange)
	}
}


private struct TeamGameTree: Equatable {
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

extension TeamGameTree {
	/* fileprivate API
	
	If not eliminated in any prior games:
	
	1) team is Liquidatable if:
	they won last game AND
	their NEXT game (last in list) either:
		a) does not exist yet;  OR b) has not yet entered Tradable state

	2) team is tradable if:
		their next game IS IN Tradable state
	*/
	
	fileprivate var nextUnfinishedGameProgress:GameProgress? {
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
	
	fileprivate var _allowLiquidationSale:Bool {
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

extension TeamGameTree {
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


struct TeamStateMgr: Equatable {
	/*  any time a team has finished their first game and IS NOT
		currently playing, then they are tradable
		(deferring quiet period until after March Madness)


	*/
	static var shared = TeamStateMgr()
	
	fileprivate var teamMap:[TeamID:TeamGameTree] = [:]
	
	fileprivate func getTree(teamID:TeamID) -> TeamGameTree {
		guard let tr = teamMap[teamID]
		else {
			// there should be no team in the system that this
			// object does not know about
			// this object is only refreshed from CURRENT game-state
			// and if the app is restarted AFTER a game is deleted
			// then other recs may point to a team that is no longer in-here
			fatalError("\(teamID) is an untracked team")
		}
		return tr
	}
	
	mutating func updateState(teams:[Team], games:[Game]) {
		// pass all teams/games each time

		for t in teams {
			if var tmTree = teamMap[t.id] {	// existing team w prior state
				tmTree.refresh(games: games)
			} else {	// new team
//				let tmTree = TeamGameTree(teamID: t.id, games: games)
				teamMap[t.id] =  TeamGameTree(teamID: t.id, games: games)
			}
		}
	}
	
	mutating func updateGameState(games:[Game]) {
		// 1-n games each time
		for g in games {
//			let gp = GameProgress.init(game: g)
			if var _ = teamMap[g.favTeamId] {
				teamMap[g.favTeamId]?.refresh(games: [g])
			} else {
				let tgt = TeamGameTree(teamID: g.favTeamId, games: [g])
				teamMap[g.favTeamId] = tgt
			}
			if var _ = teamMap[g.underTeamId] {
				teamMap[g.underTeamId]?.refresh(games: [g])
			} else {
				let tgt = TeamGameTree(teamID: g.underTeamId, games: [g])
				teamMap[g.underTeamId] = tgt
			}
		}
		print("Just updated updateGameState")
		print(teamMap)
	}
	
	mutating func clearState() {
		// for testing only
		teamMap = [:]
	}
	
	init() {
		// no other instances can be created
		// refresh prior state from disk if it exists
		
//		loadStateFromDisk()
//		NotificationEvent.goingToBackground.observe(callback: self.pushStateToDisk)
	}
	
//	private func loadStateFromDisk() {
//		if let tm = try? Disk.retrieve("eventID/teamState.json", from: .documents, as: [TeamID:TeamGameTree].self) {
//			self.teamMap = tm
//		}
//	}
//
//	private func pushStateToDisk(not:Notification) {
//		// app goingToBackground;  save data for restore later
//		print("storing game state to disk")
//		try? Disk.save(teamMap, to: .documents, as: "eventID/teamState.json")
//	}
}

extension TeamStateMgr {
	// public API
	
	func stateLabel(teamID:String, isOwned:Bool) -> String {
		// label for team action button based on prior or next game
		let gt = getTree(teamID:teamID)
		if isOwned {
			// valid vals are: GAME ON, TRADE, LIQUIDATE
			if gt._allowLiquidationSale {
				return ""	// Strings.liquidate.localized()
			}
		}
		return gt.lastGameState.label
	}
	
	func isTradable(teamID:String) -> Bool {
		if teamID == "duke-bask-nca-dur" {
			print(teamID)
		}
		return getTree(teamID:teamID).isTradable
	}
	
	func isTradable(team:Team) -> Bool {
		return isTradable(teamID:team.id)
	}
	
	func isTradable(game:Game) -> Bool {
		return isTradable(teamID:game.favTeamId)
	}
	
	func liquidateSaleAllowed(teamID:String) -> Bool {
		// true if you can sell a winner between games
		// even tho (especially when) the next game is not tradable
		return getTree(teamID:teamID).allowLiquidationSale
	}
	
	func isEliminated(teamID:String) -> Bool {
		return getTree(teamID:teamID).isEliminated
	}
	
	func nextGame(teamID:String) -> Game? {
		// specifically means unplayed or unfinished (ongoing) game
		return getTree(teamID:teamID).nextUnfinishedGameProgress?.game
	}
	
	func containsGame(id:String) -> Bool {
		// see if game was stored
		print("teamMap count: \(teamMap.count)")
		for (id, tgt) in self.teamMap {
			if tgt.containsGame(id: id) {
				return true
			}
		}
		return false
	}
}


private func returnGameTreeAndNextIdx(teamID:TeamID, games:[Game]) -> ([GameProgress], Int?) {
	// next index is pointer to game about to start
	// this should ALWAYS be the last game in list (or not exist) because
	// new games not created until outcome of prior game is known
	// called by TeamGameTree init & refresh
	
	var relatedGames = games.filter( {$0.favTeamId == teamID || $0.underTeamId == teamID} )
	// sort from soonest to farthest out (ascending order)
	relatedGames.sort(by: { (g1, g2) in g1.scheduledStartDtTm < g2.scheduledStartDtTm } )
	
	var gameTree = [GameProgress]()
	var idxOfGameAfterLastEndedGame:Int?
	var nextUnstartedGameFound = false
	for g in relatedGames {
		gameTree.append(GameProgress(game:g))
		// remember index of the current/next unfinished game
		if !nextUnstartedGameFound && !g.isOver {
			idxOfGameAfterLastEndedGame = gameTree.count - 1
			nextUnstartedGameFound = true
		}
	}
	return (gameTree, idxOfGameAfterLastEndedGame)
}


