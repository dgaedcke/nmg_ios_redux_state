//
//  Sport.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/5/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

import Foundation
import UIKit

class Sport: CustomStringConvertible {
	
	var id:String 		// lets use name literal for this table as GAE-dataStore key
	var name:String = ""	// Soccer, Basketball, etc
	var active:Bool = true	// is in season
	var maxPreSplitPrice:Int = 20	//
	var gameTerm:String = "Game" // tennis uses match
	var eventTerm:String = "Tournament"	// competition, contest, championship, meeting, meet, event, match, round robin
	
//	var iconName:String = "team_icon"	// a ModifierKey for image URL
//	var backgroundImageName:String = "team_icon"  // ModifierKey for image URL
	
	var iconImageName:String {
		return "icon-\(id.lowercased())"
	}
	
	var icon:UIImage {
		if let img = UIImage(named: iconImageName) {
			return img
		} else {
			return UIImage(named: "icon-football")!
		}
	}
	
	var bannerImageName:String {
		return "banner_\(id.lowercased())"
	}
	
	var bannerImage:UIImage {
//		print("looking for \(bannerImageName)")
		if let b = UIImage(named: bannerImageName) {
			return b
		} else {
			return UIImage(named: "banner_allsport")!
		}
	}
	
	var displayName:String {
		return name
	}
	
	var description: String {
		// for printing only
		return self.name
	}
	
//	var fullNodePath:String {
//		// actual key in the DB
//		return "\(Sport.tableRoot)/\(self.name)"
//	}
	
	var trackedMetrics:[Int] {
		// StatMetric
		return []
	}
	
	var statNodeCount:Int {
		// how many stat-Nodes should be found under this node in the Firebase data
		return trackedMetrics.count
	}
	
	init(id:String, name:String, active:Bool) {
		self.id = id
		self.name = name
		self.active = active
//		self.iconName = iconName
//		self.backgroundImageName = ""
	}
	
//	static func byId(id:String) -> Sport {
//		return AppState.shared.allSports.byId(id:id)
//	}
	
//	static func defaultSortOrder(sportIds:[String]) -> ([String],[String:Sport]) {
//		/*  build a new list of tuples which includes Sport name
//			sort by name
//			map back to a single value list of IDs
//		*/
//		var sortedList:[ (String, Sport) ] = sportIds.map { sid in return (sid, Sport.byId(id: sid)) }
//		sortedList.sort(by: {t1, t2 in t1.1.name < t2.1.name })
//		return (sortedList.map { tup in tup.0 }, Dictionary(elements: sortedList) )
//	}
	

}



