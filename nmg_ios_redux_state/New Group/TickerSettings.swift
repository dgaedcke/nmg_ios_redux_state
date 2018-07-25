//
//  Ticker.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 11/26/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

// PSEUDOCODE .. don't copy into project

struct TickerSettings:Codable {
	// users ticker preferences
	var source:DataSource = .selectedEvent
	var displayMode:String = ""	// direction or stutter
	var speed:Int = 2	// from 0 (slowest) to 4 (fastest)
	var selectedEventId:String? = nil
	
	init(source: DataSource, displayMode: String, speed: Int) {
		self.source = source
		self.displayMode = displayMode
		self.speed = speed
	}
	
	static func seed() -> TickerSettings {
		return TickerSettings(source: .selectedEvent, displayMode: "", speed: 2)
	}
	
	enum DataSource:String, Codable {
		case portfolio = "portfolio"	// initially empty
		case watchList = "watchList"	// initially empty
		case selectedEvent = "selectedEvent"	// if only one event is active, allEvents will cover it
		case allEvents = "allEvents"	// this is the default
		
		static var all:[TickerSettings.DataSource] = [portfolio, watchList, selectedEvent, allEvents]
		
		static var labelMap:[String:TickerSettings.DataSource] = [
//			Strings.Portfolio.localized(): .portfolio
//			, Strings.WatchList.localized() : .watchList
//			, Strings.SelectedEvent.localized() : .selectedEvent
//			, Strings.AllEvents.localized() : .allEvents
			"Portfolio": .portfolio
			, "WatchList" : .watchList
			, "SelectedEvent" : .selectedEvent
			, "AllEvents" : .allEvents
		]
	}
	
	private enum CodingKeys:String, CodingKey {
		case source
		case displayMode // = "displayMode"
		case speed // = "speed"
		case selectedEventId
	}
}


