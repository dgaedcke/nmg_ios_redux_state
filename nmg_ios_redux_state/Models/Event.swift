//
//  Event.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/15/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

import Foundation
import UIKit

class Event: Codable, Equatable, StateObj {
	/*  aka tournament
		
	*/
	
	// stored fields
	var id: String = ""		// our internal private EID		// always uppercased
	var sportId:String!		// which sport
	var publicEventName:String = ""	// any public ID used to describe this tourney; used to harvest news; not guaranteed unique
	var name:String = ""	// eg March Madness
	var subTitle:String = ""
	var scheduledStartDtTm:Date!
//    var profile = EventProfile.Mock()
//    var results = EventResult.Mock()
	
	var displayName:String {
		return name
	}
	
	var dateSummary:String {
		return ""
//		return "\(startDtTm.toString(dateFormat: "MMM dd"))-\(results.endDttm.toString(dateFormat: "MMM dd"))"
	}
	
	var description: String {
		return "Event: \(name)  \(id)"
	}
		
//	var sport:Sport {
//		return Sport.byId(id: self.sportId)
//	}
	
//	var icon:UIImage {
//		return self.sport.icon
//	}
	
//	static func byId(eventId:String) -> Event {
//		return Event()
//	}
	
	required init(id:String, name:String, tournamentId:String, sportId:String) {
		self.id = id
		self.name = name
		self.publicEventName = tournamentId
		self.sportId = sportId
		
		// fill in some fake dates
		let randIntStart = arc4random_uniform(UInt32(100000))
		let randIntEnd = randIntStart + arc4random_uniform(UInt32(100000))
		self.scheduledStartDtTm = Date().addingTimeInterval(TimeInterval(randIntStart))
//        self.results.finishedAtDtTm = Date().addingTimeInterval(TimeInterval(randIntEnd))
	}
	

	static let canUpdate:Bool = false
	static let canDelete:Bool = false
	
	static func == (lhs: Event, rhs: Event) -> Bool {
		return lhs.id == rhs.id
	}
}



