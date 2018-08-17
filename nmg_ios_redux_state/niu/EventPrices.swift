//
//  EventPrices.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 2/18/18.
//  Copyright © 2018 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

import Foundation


//struct EventPricesWrapper {
//	// first key is the eventID and next is the teamID
//	
//	private var _masterDict = [String:TeamPrice]()
//	private var all = [String: [String:TeamPrice]]()
//	
//	static var shared = EventPricesWrapper()
//	
//	var allTeamPrices:[TeamPrice] {
//		return Array(_masterDict.values)
//	}
//	
//	func priceFor(teamID:String) -> TeamPrice {
//		if let tp = _masterDict[teamID] {
//			return tp
//		} else {
//			print("ERR:  no price found for \(teamID)")
//			return TeamPrice.seed
//		}
//	}
//	
////	func updateEvent(eventID:String, teamPrices:[TeamPrice]) {
////		//
////		if self.all[eventID] == nil {
////			self.all[eventID] = [String:TeamPrice]()
////		}
////
////		for tp in teamPrices {
////			self.all[eventID]![tp.teamId] = tp
////			self._masterDict[tp.teamId] = tp
////		}
////	}
//	
//	func pricesFor(eventID:String) -> [TeamPrice] {
//		//
//		if let teamDict = self.all[eventID] {
////			return teamDict.map { $0.value }
//			return Array(teamDict.values)
//		} else {
//			print("Err: no prices found for \(eventID)")
//			return []
//		}
//	}
//	
//	func eventContains(eventID:String, teamId:String) -> Bool {
//		
//		if let teamDict = self.all[eventID] {
//			return teamDict[teamId] != nil
//		} else {
//			return false
//		}
//	}
//	
//	func countFor(eventID:String) -> Int {
//		if let teamDict = self.all[eventID] {
//			return teamDict.count
//		} else {
//			return 0
//		}
//	}
//	
////	func setTeamEliminated(eventID:String, teamPrice:TeamPrice) -> TeamPrice {
////		// zero out all prices for this team
////		var tp = teamPrice
////		tp.price = 0
////		tp.delta = 0
//////		self.updateEvent(eventID: eventID, teamPrices: [tp])
////		return tp
////	}
//}




//struct EventPrices:Codable {
//	// represents structure of data at:  firebase/eventPrices
//	var eventId = ""
//	var teamsDict:[String:TeamPrice] = [:]
//
//	var teams:[TeamPrice] {
//		return Array(teamsDict.values.map{ $0 })
//	}
//
//	mutating func replaceTeamPrice(teamPrice:TeamPrice) {
//		// update a team in the array
//		self.teamsDict[teamPrice.teamId] = teamPrice
//	}
//
//	func contains(teamId:String) -> Bool {
//		return teamsDict[teamId] != nil
//	}
//}
//
//
//extension Array where Element == EventPrices {
//	// list of active events with team prices nested inside
//	// used to merge with teamIds to generate the ticker-data
//	// this single array lives on DataContext
//
//	private func getEventRec(eventId:String) -> EventPrices? {
//		if let idx = self.index(where: {t in t.eventId == eventId } ), idx < self.count {
//			return self[idx]
//		} else {
//			return nil
//		}
//	}
//
//	//	mutating func updateTeam(eventId: String, tp:TeamPrice) {
//	//		if let er = self.getEventRec(eventId:eventId) {
//	//			// do not use var er above as it's a copy
//	//			er.teamsDict[tp.teamId] = tp
//	//		} else {
//	//			self.insert( EventPrices(eventId:eventId, teamsDict:[tp.teamId:tp]), at: 0)
//	//		}
//	//	}
//}

