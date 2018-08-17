//
//  TeamPrices.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 12/2/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

import Foundation


struct TeamPrice:Codable, Equatable {
	// FIXME:  I am manually decoding this object in TeamPricesApi
	// so the types are rigid;
	// each leaf-node from: firebase/eventPrices/someEvent/<teamID>
	// stored in EventPrices which is stored in TeamPricesApi.shared.prices
	var eventId:RDXTypes.EventID = ""
	let teamId:RDXTypes.TeamID		// always uppercased
	let price:Double	// NMGCurrency
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


