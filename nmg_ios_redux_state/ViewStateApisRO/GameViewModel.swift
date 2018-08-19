//
//  GameViewModel.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/18/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation



struct TeamViewModel {
	// wrapper for team to provide informative API for views
	let event:Event
	let team:Team
	let price:TeamPrice
	let portfolioSubset:TeamViewModel.UserPortfolioSubsetWrapper
	let assetKey:AssetKey
	let isWatched:Bool
	
	struct UserPortfolioSubsetWrapper {
		// part of portfolio limited to this particular team
		var stateLabel:String = "unowned"	// convert to enum .rawValue
		
		var isOwned:Bool = false
	}
}

extension TeamViewModel {
	// public API
	
	init(event:Event, team:Team, portfolioState:PortfolioState, acctState:AccountState, pricesState:PricesState?) {
		self.event = event
		self.team = team
		self.price = pricesState?.priceFor(teamID: team.id, in: event.id) ?? TeamPrice.seed
		self.portfolioSubset = TeamViewModel.UserPortfolioSubsetWrapper(stateLabel: "", isOwned: false)
		self.assetKey = AssetKey(teamId: team.id, eventId: event.id)
		self.isWatched = acctState.isWatched(assetKey: self.assetKey)
	}
	
//	var assetKey:AssetKey {
//		return AssetKey(teamId: team.id, eventId: event.id)
//	}
	
	var shortNameDisplay:String {
		return team.shortNameDisplay
	}
	
	var offerPrice:Double {
		return price.price
	}
	
	var isOwned:Bool {
		return portfolioSubset.isOwned
	}
}




struct GameTeamViewModel {
	/* wrapper of game state
		used by views to access all needed info about event, teams, prices, etc
		only valid at a specific point in time
	
	since many views may use this wrapper for different requirements
	you will just have to add different init() methods that govern
	what to extract from the main state object and what to expose as objects or properties
	*/
	
	// MARK: - Properties
	let event:Event
	let game:Game
	let favTeamVM:TeamViewModel
	let underTeamVM:TeamViewModel?	// can be empty for Fantasy games
	
	init(state:AppState, gameID:RDXTypes.GameID, teamID:RDXTypes.TeamID) {
		// construct instance from AppState
		// based on key's passed
		let game:Game = state.entityRecs.getLatest(id: gameID)!
		self.event = state.entityRecs.getLatest(id: game.eventId)!
		self.game = game
		
		let favTeam:Team = state.entityRecs.getLatest(id: self.game.favTeamId)!
		self.favTeamVM = TeamViewModel(event: self.event, team: favTeam, portfolioState: state.portfolioState, acctState: state.accountState, pricesState: state.pricesState)
		if let underId = self.game.underTeamId, let underTeam:Team = state.entityRecs.getLatest(id: underId) {
			self.underTeamVM = TeamViewModel(event: self.event, team: underTeam, portfolioState: state.portfolioState, acctState: state.accountState, pricesState: state.pricesState)
		} else {
			self.underTeamVM = nil
		}
	}
	
	static func listFor(state:AppState, eventID:RDXTypes.EventID?, discriminatorID:String?, date:Date?, gameIDs:[RDXTypes.GameID]?) -> [GameTeamViewModel] {
		// get list of GVM for the view depending on what he sends in args 2-5
		
		return []
	}
}

extension GameTeamViewModel {
	// public API in support of VC/view
	
	var gameStatus: GamePlayStatus {
		return game.gameStatus
	}
	
	var isOver:Bool {
		return gameStatus.isOver
	}
	var nameVsDisplay:String {
		// fantasy games only have 1 team
		if isFantasyGame {
			return "\(favTeamVM.shortNameDisplay)"
		}
		return "\(favTeamVM.shortNameDisplay) vs \(underTeamVM?.shortNameDisplay ?? "err: misunderteam")"
	}
	
	var name: String {
		return nameVsDisplay
	}
	
	var favTeamPrice: Double {
		return favTeamVM.offerPrice
	}
	
	var underTeamPrice: Double {
		return underTeamVM?.offerPrice ?? 0.0
		
	}
	
	var isFantasyGame:Bool {
		return underTeamVM == nil
	}

	var sectionKey: String {
		return event.id + "-" + game.bracket
	}
	
	func isFavorite(teamID:RDXTypes.TeamID) -> Bool {
		return favTeamVM.team.id == teamID
	}
	
	func portfolioWrapper(favorite:Bool) -> TeamViewModel.UserPortfolioSubsetWrapper? {
		if favorite {
			return favTeamVM.portfolioSubset
		} else if let underTm = underTeamVM {
			// not a fantasy
			return underTm.portfolioSubset
		}
		return nil
	}
	
	func portfolioStateLabel(favorite:Bool) -> String {
		return portfolioWrapper(favorite: favorite)?.stateLabel ?? "unowned"
	}
	
	func stateInGameLabel(for teamId:String) -> String {
		return stateInGame(for: teamId).label
	}
	
	func teamIsWatched(teamId:RDXTypes.TeamID) -> Bool {
		if isFavorite(teamID: teamId) {
			return favTeamVM.isWatched
		} else if !isFantasyGame {
			return underTeamVM?.isWatched ?? false
		}
		return false
	}
	
	var favTeamIsWatched:Bool {
		return teamIsWatched(teamId: favTeamVM.team.id)
	}
	
	var underTeamIsWatched:Bool {
		if let id = underTeamVM?.team.id {
			return teamIsWatched(teamId: id)
		}
		return false
	}
	
	
	var timeUntilStart:DateComponents {
		let now = Date()
		let calendar = Calendar.current
		let components = calendar.dateComponents([.hour, .minute, .second],
												 from: now,
												 to: self.game.scheduledStartDtTm)
		return components
	}
	
	var timeUntilStartFormatted: String {
		let c = self.timeUntilStart
		return "\(c.hour ?? 0):\(c.minute ?? 0):\(c.second ?? 0)"
	}
	

	
	var description: String {
		return game.id
	}
	
	func startTrade(for teamId:String) {
		
	}
	
	func stateInGame(for teamId:String) -> TeamGameCompletionStatus {
		return .scheduled
		
//		if gameStatus.isUnresolved {
//			return .scheduled
//		} else {
//			let _ = self.event
//			if self.winnerTeamId == teamId {
//				// FIXME: enable next 2 lines
//				//                return event.profile.teamAdvanceMethod == .bestOfAllGames ? .won : .advancing
//				return TeamGameCompletionStatus.scheduled
//			} else {
//				//                return event.profile.teamAdvanceMethod == .bestOfAllGames ? .lost : .eliminated
//				return TeamGameCompletionStatus.scheduled
//			}
//		}
	}
}
