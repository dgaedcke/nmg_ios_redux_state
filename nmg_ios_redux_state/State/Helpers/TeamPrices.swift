//
//  TeamPrices.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 12/2/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

import Foundation
//import FirebaseDatabase

protocol PriceChangeDelegateProto {
	// used to notify AppState when a teamsPrice changes in:  firebase/eventPrices
	func teamPriceDataLoaded()	// when all data is loaded
	func teamPriceChange(teamPrice:TeamPrice)
}


struct TeamPrice:Codable, Equatable {
	// FIXME:  I am manually decoding this object in TeamPricesApi
	// so the types are rigid;
	// each leaf-node from: firebase/eventPrices/someEvent/<teamID>
	// stored in EventPrices which is stored in TeamPricesApi.shared.prices
	var eventId:NTA.EventID = ""
	let teamId:NTA.TeamID		// always uppercased
	let price:Double
	let delta:Int
	let asOfDtTm = Date()
	
	var ticker:String {
		return ""	// AppState.shared.teamFromID(id:teamId).ticker
	}
	
	init(teamId:String, data:[String:Double]) {
		self.teamId = teamId.lowercased()
		// server keeps prices in CENTS to avoid rounding issues
		self.price = (data["price"] ?? 0.0) / 100	// as? Double
		self.delta = Int(data["delta"] ?? 0.0) / 100
	}
	
//	init(currentPrice: Double, recentChange: Double, teamId:String) {
//		self.teamId = teamId.lowercased()
//		self.price = currentPrice
//		self.delta = recentChange
//	}
	
//	init?(snapshot:DataSnapshot) {
//		if let vals = snapshot.value as? [String:Double] {
//			self.init(teamId:snapshot.key, data: vals )
//		} else {
//			return nil
//		}
//	}
	
	init(teamId:String, currentPrice: Double, recentChange: Double) {
		self.teamId = teamId.lowercased()
		self.price = currentPrice
		self.delta = Int(recentChange)
	}
	
	static var seed:TeamPrice {
		return TeamPrice(teamId: "_UNK?", currentPrice:0, recentChange:0)
	}
	
	static func initialPricesForEvent(data: [String: [String:Double]] ) -> [TeamPrice] {
		var arr = [TeamPrice]()
		for (teamID, rec) in data {
			arr.append(self.init(teamId: teamID, data: rec ))
		}
		return arr
	}
	
//	static func mockArray() -> [TeamPrice] {
//		return [ TeamPrice(currentPrice: 2.32, recentChange: 0.45, teamId: "KU")
//			, TeamPrice(currentPrice: 3.82, recentChange: -0.15, teamId: "Zags")
//			, TeamPrice(currentPrice: 1.49, recentChange: 0.27, teamId: "MI")
//			, TeamPrice(currentPrice: 5.11, recentChange: -1.22, teamId: "RAV")
//			, TeamPrice(currentPrice: 1.49, recentChange: 0.27, teamId: "VKS")
//			, TeamPrice(currentPrice: 3.82, recentChange: -0.81, teamId: "BRNS")
////			, TeamPrice(currentPrice: 1.49, recentChange: 0.47, teamId: "Four")
////			, TeamPrice(currentPrice: 3.82, recentChange: -0.55, teamId: "Five")
////			, TeamPrice(currentPrice: 1.49, recentChange: 2.03, teamId: "Sex")
//		]
//	}
}



// struck for Ticker collection view:

struct TeamQuote {
	// data for stock-ticker across bottom of main UI
	// created from a TeamPrice record as firebase/eventPrices notify us of changes
	// also used as a notify msg to other parts of the app ui when prices change
	
	let teamId:String		// unique ID
	let ticker:String		// 4-6 chars
	let currentPrice:Double	// eg $3.75
	let recentChange:Double	// eg +0.45  or -0.14
	
	init(teamPrice:TeamPrice) {
		self.teamId = teamPrice.teamId
		self.ticker = teamPrice.ticker	// look this up
		self.currentPrice = teamPrice.price
		self.recentChange = Double(teamPrice.delta)
	}
}

extension Array where Element == TeamQuote {
	// list of team quotes for the ticker bar
	
	mutating func updateTeam(tq:TeamQuote) {
		
		if let idx = self.index(where: {$0.teamId == tq.teamId} ) {
			self[idx] = tq
		} else {
			self.insert( tq, at: 0)
		}
	}
}

