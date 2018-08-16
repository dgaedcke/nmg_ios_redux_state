//
//  PricesState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


struct EventPrices: Equatable {
	let eventID:RDXTypes.EventID
	var teamPrices:[RDXTypes.TeamID: TeamPrice] = [:]
	
	mutating func updateTeam(teamPrice:TeamPrice) {
		self.teamPrices[teamPrice.teamId] = teamPrice
	}
}


struct PricesState: StateType, Equatable {
	/*  team prices
		all GLOBAL data (same for all users)
	*/
	
	private var eventPrices: [RDXTypes.EventID:EventPrices] = [:]
	
	mutating func updateTeamIn( eventID:RDXTypes.EventID, teamPrice:TeamPrice) {
		if self.eventPrices[eventID] == nil {
			self.eventPrices[eventID] = EventPrices(eventID: eventID, teamPrices: [:])
		}
		self.eventPrices[eventID]?.updateTeam(teamPrice: teamPrice)
	}
	
	func priceFor(teamID:RDXTypes.TeamID, in eventID: RDXTypes.EventID) -> TeamPrice {
		guard let ep = self.eventPrices[eventID]
			, let tp = ep.teamPrices[teamID]
		else {
			return TeamPrice(teamId: teamID, currentPrice: 0, recentChange: 0)
		}
		return tp
	}
}
