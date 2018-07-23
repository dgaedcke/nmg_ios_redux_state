//
//  Team.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/5/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

import Foundation
import UIKit


class Team: Codable {
	//
	// stored fields
	var id: String = ""		// always uppercased
	var sportId:String!
	var homeTownId:String = ""
	
	internal var mascot:String = ""	// renamed to Mascot below
	internal var longName:String = ""	// renamed to longName below
	internal var shortName:String = ""
	var ticker:String = ""
	
	var eliminationDtTm = Date.distantFuture	// when team eliminated from recent Event
	var currentEventId:String = ""	// not accurate in Firebs yet
	// added to control different Team behavior
	// move these to attached Sport entity
	var leagueType:Int = 0
	var leagueId:String = ""
	
	// values from TeamTradeConfig
	var openingPrice =  8.00
	var eventSeed:Int = 8
	var eventRank:Int = 4
	var winLossTieRecord:String? = "3-4-0"
//	var status:TeamGameCompletionStatus = .roster
	
//	var statusLabel:String {
//		return TeamStateMgr.shared.stateLabel(teamID: self.id, isOwned: self.isOwned)
//	}
	
	var name:String {
		// only here for dbModel interface compliance;  NIU
		return mascot
	}
//	var offerPrice:Double {
//		// set after init (not in codingkeys)
//		let tp = AppState.shared.priceInfoForTeam(teamId: self.id)
//		return Double(tp.price)
//	}
	
	var longNameDisplay:String {
		return longName
	}
	
	var shortNameDisplay:String {
		return shortName
	}

	
	private enum CodingKeys: String, CodingKey {
		// intentionally omitting offerPrice & winLossTieRecord (updated later)
		case id
		case sportId
		case homeTownId
		case mascot	// mascot
		case shortName
		case longName	// longname
		case ticker
		case eliminationDtTm
		case currentEventId
//		case status		// not consistently in Firebase
		case openingPrice
		case eventRank = "rank"
		case eventSeed = "seed"
		case winLossTieRecord = "startWinLossTieRecord"
		// going to move leage type & ID to the sport entity
		//		case leagueType
		case leagueId
	}
	
	required init(id:String, name:String, shortName:String, homeTownId:String, sportId:String) {
		self.id = id
		self.mascot = name
		self.sportId = sportId
		self.homeTownId = homeTownId
		self.shortName = shortName
	}
	
//	static func byId(id:String) -> Team {
//		return AppState.shared.teamFromID(id:id)
//	}
	
	static var seed:Team = {
		return Team(id:"123", name:"Not Found?", shortName:"?NA?", homeTownId:"NIU", sportId:"NIU")
	}()
	
	static let canUpdate:Bool = true
	static let canDelete:Bool = false
	
	var description: String {
		return "Team: \(mascot)  \(id)"
	}
}

extension Team {
	// trading
	
	var assetKey:String {
		// temp handle server side bugs;  FIXME
		print("1)  \(self.currentEventId)")

		return ""
	}
	
//	var isWatched:Bool {
//		return AppState.shared.isWatched(teamId: self.id)
//	}
//
//	var isOwned:Bool {
//		return AppState.shared.userPortfolio.isOwned(teamId: self.id)
//	}
//
//	func toggleWatchState() {
//		AppState.shared.toggleWatchState(teamId:id)
//	}
	
}


