//
//  Match.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/9/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

import Foundation
import UIKit


struct Game {
	
	var id:String = ""		// composed like:  eventId_favTeamId_underTeamId
	var favTeamId:String = ""		// expected to win
	var underTeamId:String = ""		// underdog
	var winnerTeamId:String = ""	// empty until game completed
	var sportId:String = ""
	var eventId:String = ""
	var actualStartDtTm:Date = Date()
	var scheduledStartDtTm:Date = Date()
	var finishedAtDtTm:Date = Date()
	var publicGameName:String = ""	// any public name or title for this game
//	var title:String = ""	// public freeform name
	
	var bracket:String = ""	// what section of event / Tournament is it in
	var locationId:String = ""	// true (GPS location); cannonical
	var location:String = "-FIXME-"	// display location
	
//	var gameStatus = GamePlayStatus.preGame
	// removed lps as not needed on game
//	var loserProgressStatus = TeamGameCompletionStatus.eliminated
	
	var isOver:Bool {
		return true
	}
//	var nameVsDisplay:String {
//		return "\(favTeam.shortNameDisplay) vs \(underTeam.shortNameDisplay)"
//	}
	
//	var name:String {
//		return nameVsDisplay
//	}
//	
//	var favTeam:Team {
//		return Team.byId(id:favTeamId)
//	}
//	
//	var underTeam:Team {
//		return Team.byId(id:underTeamId)
//	}
//	
//	var favTeamPrice:Double {
//		return favTeam.offerPrice
//	}
//	
//	var underTeamPrice:Double {
//		return underTeam.offerPrice
//	}
//	
//	var event:Event {
//		return Event.byId(eventId: self.eventId)
//	}
	
	var sectionKey:String {
		return eventId + "-" + bracket
	}
	
//	private static var userPortfolioState:PortfolioState {
//		return AppState.shared.userPortfolio
//	}
//
//	func portfolioStatus(for teamId:String) -> PortfolioAssetStatus? {
//		let ak = AssetKey(teamId: teamId, eventId: self.eventId)
//		return Game.userPortfolioState.holdStateForTeam(assetKey:ak)
//	}
//
//	func portfolioStateLabel(for teamId:String) -> String {
//		return portfolioStatus(for:teamId)?.rawValue.localized() ?? "unowned"
//	}
//
//	func stateInGame(for teamId:String) -> TeamGameCompletionStatus {
//		// FIXME:  which tam won?
//		if gameStatus.isUnresolved {
//			return .scheduled
//		} else {
//			let _ = self.event
//			if self.winnerTeamId == teamId {
//				// FIXME: enable next 2 lines
////				return event.profile.teamAdvanceMethod == .bestOfAllGames ? .won : .advancing
//				return TeamGameCompletionStatus.scheduled
//			} else {
////				return event.profile.teamAdvanceMethod == .bestOfAllGames ? .lost : .eliminated
//				return TeamGameCompletionStatus.scheduled
//			}
//		}
//	}
	
//	func stateInGameLabel(for teamId:String) -> String {
//		return stateInGame(for: teamId).label
//	}
	
	func teamIsWatched(teamId:String) -> Bool {
		return false
	}
	
	var favTeamIsWatched:Bool {
		return teamIsWatched(teamId: favTeamId)
	}
	
	var underTeamIsWatched:Bool {
		return teamIsWatched(teamId: underTeamId)
	}
	
//	static func byId(id:String) -> Game {
//		return AppState.shared.allGames.byId(id: id)
//	}
	
	var timeUntilStart:DateComponents {
		let now = Date()
		let components = Calendar.current.dateComponents([.hour, .minute, .second], from: now, to: self.scheduledStartDtTm)
		return components
	}
	
	var timeUntilStartFormatted: String {
		let c = self.timeUntilStart
		return "\(c.hour ?? 0):\(c.minute ?? 0):\(c.second ?? 0)"
	}
	
	init(id:String, favTeamId:String, underTeamId:String, sportId:String, eventId:String, actualStartDtTm:Date) {
		self.id = id
		self.favTeamId = favTeamId
		self.underTeamId = underTeamId
		self.sportId = sportId
		self.eventId = eventId
		self.actualStartDtTm = actualStartDtTm
		self.publicGameName = ""
	}
	
	static var seed:Game = {
		return Game(id:"123", favTeamId:"NIU", underTeamId:"NIU", sportId:"NIU", eventId:"NIU", actualStartDtTm:Date() )
	}()
	
	// stored props for conformance with DbModelProto

	static let canUpdate:Bool = true
	static let canDelete:Bool = false
	
	var description: String {
		return id
	}
}


extension Game {
	var startDateAsString:String {
		return ""
	}
	var startTimeAsString:String {
		return "11:30AM ET"	// scheduledStartDtTm.
	}
}



//extension Game: RTUniqueObservableProto {
//	// make game comply so it can stay in sync w Firebase
//	var uid: String {
//		return id
//	}
//}






