//
//  Match.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/9/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

import Foundation
import UIKit
import RTDM

struct Game: DbModelProto, RTObservableProto, StateValueProto {
	
	// MARK: - RTObservableProto properties
	public static var rtNodePath: String = "/clientGlobal/game"
	
	// MARK: - DbModelProto properties
	static var dbPathPrefix = EntityType.sharedTable.dbPathPrefix
	static let tableName = "game"
	static let keyGenMethod = KeyGenType.server
	static let canUpdate:Bool = true
	static let canDelete:Bool = false
	
	// MARK: - Properties
	
	/// Unique id - composed like:  eventId_favTeamId_underTeamId
	var id: String = ""
	/// Team-id of expected to win
	var favTeamId: String = ""
	/// Team-id of underdog
	var underTeamId: String?
	/// Team-id of winner. Will be empty until game completed
	var winnerTeamId: String = ""
	/// any public name or title for this game
	var publicGameName: String = ""
	/// what section of event / Tournament is it in
	var bracket:String = ""
	var sportId: String = ""
	var eventId: String = ""
	var actualStartDtTm: Date = Date()
	var scheduledStartDtTm: Date = Date()
	var finishedAtDtTm: Date = Date()
	
	/// true (GPS location); cannonical
	var locationId: String = ""
	var location:String = "-FIXME-"	// display location
	
	var gameStatus = GamePlayStatus.preGame
	// removed lps as not needed on game
	// var loserProgressStatus = TeamGameCompletionStatus.eliminated
	
	var isOver:Bool {
		return gameStatus.isOver
	}
	
	var name: String {
		return publicGameName
	}

	
	init(id:String,
		 favTeamId:String, underTeamId:String,
		 sportId:String,
		 eventId:String, actualStartDtTm:Date) {
		
		self.id = id
		self.favTeamId = favTeamId
		self.underTeamId = underTeamId
		self.sportId = sportId
		self.eventId = eventId
		self.actualStartDtTm = actualStartDtTm
		self.publicGameName = ""
	}
	
	var description: String {
		return id
	}
}

// MARK: - Comparable protocol
extension Game: Comparable {
	
	static func ==(lhs: Game, rhs: Game) -> Bool {
		return lhs.id == rhs.id
	}
	
	static func < (lhs: Game, rhs: Game) -> Bool {
		return lhs.scheduledStartDtTm < rhs.scheduledStartDtTm
	}
}

extension Game: EntityRecProto {
	// section head resolver
}

extension Game {
	var startDateAsString:String {
		return scheduledStartDtTm.description	// FIXME
	}
	var startTimeAsString:String {
		return "11:30AM ET"	// scheduledStartDtTm.
	}
}





