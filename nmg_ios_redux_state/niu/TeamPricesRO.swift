//
//  TeamPricesApi.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/11/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

/*
	all users pull down ALL team-price data at app-start
	and then get updates as each team price changes
	now that I have all teams & their current prices
	I don't need to monitor/read any data EXCEPT the watch-list
	which I control anyway
	all other ticker choices can be just filters of the master price-list

*/

// PSEUDOCODE .. don't copy into project

//import Foundation
////import PromiseKit
////import FirebaseDatabase
////import RTDM
//
//
//class TeamPricesApi {
//	// singleton to manage all team price data reading & changes
//	// private properties & methods
//	
//	private var changeDelegate:PriceChangeDelegateProto?	// who to notify when prices change
//	
//	// in the middle of an order, we watch one team constantly for price changes
//	private var oneTeamChangeDelegate:PriceChangeDelegateProto?
//	private var oneObservedTeam:Team?
//	
//	private var settings:TickerSettings = TickerSettings.seed()
//	
//	// _pricesByEvent holds full data from server
////	private var _eventPriceWrapper:EventPricesWrapper
//	
//	
//	// _allTeamPrices is master list of known prices for all loaded teams
//	// filteredBySource() below returns subset of _allTeamPrices
//	// based on self.(ticker)settings
//	private var _allTeamPrices:[TeamPrice] {
//		return _eventPriceWrapper.allTeamPrices
//	}
//	
//	// tracking for changes in data source
//	private var oldSource:TickerSettings.DataSource = .allEvents
//	
////	private func saveSettingsToServer() {
////		let conn = RealtimeUtil.getDbConnection(path:self.pathForTickerSettings)
////		do {
////			let jsonData = try RTDM.defaultEncoder.encodeToJSON(self.settings)
////			conn.setValue( jsonData )
////		} catch {
////			print("ticker: saveSettingsToServer")
////			print(error)
////		}
////	}
//	
////	private var pathForTickerSettings:String {
////		let userId = AppState.shared.currentUser?.id ?? "unkUser"
////		return "/user/\(userId)/tickerSettings"
////	}
//	
//	private var eventPricesPath:String {
//		return "/eventPrices"
//	}
//	
//	private init() {
//		// no other instances can be created
////		self._eventPriceWrapper = EventPricesWrapper.shared
//	}
//	
//	static var shared = TeamPricesApi()
//}
//
//
//
//extension TeamPricesApi {
//	// public API to this singleton
//	
//	func priceInfoForTeam(teamId:String) -> TeamPrice {
//		return _eventPriceWrapper.priceFor(teamID:teamId)
//	}
//	
//	func priceForTeam(id :String) -> Double {
//		return priceInfoForTeam(teamId: id).price
//	}
//	
//	var prices:[TeamPrice] {
//		return _allTeamPrices
//	}
//	
//	var tickerDataSource:TickerSettings.DataSource {
//		return settings.source
//	}
//	
//	func pricesToFilteredQuotes() -> [TeamQuote] {
//		// reduce all prices to a subset of quotes for the ticker quotes
//		// FIXME:  hack to get ticker showing teams
//		let filteredData:[TeamPrice] = self.filteredBySource()
//		return filteredData.map { TeamQuote(teamPrice: $0) }
//	}
//	
//	func setAllTeamsDelegate(del:PriceChangeDelegateProto) {
//		self.changeDelegate = del
//	}
//	
//	func setOneTeamChangeDelegate(del:PriceChangeDelegateProto, team:Team) {
//		self.oneTeamChangeDelegate = del
//		self.oneObservedTeam = team
//	}
//	
//	func cancelOneTeamChangeDelegate() {
//		self.oneTeamChangeDelegate = nil
//		self.oneObservedTeam = nil
//	}
//	
//	func getSettings() -> TickerSettings {
//		return self.settings
//	}
//	
//	func setSettings(settings:TickerSettings) {
//		self.settings = settings	// replace settings object
////		saveSettingsToServer()		// store to backend
//	}
//	
//	func setCurrentEvent(event:Event?) {
//		if let ev = event {
//			self.settings.selectedEventId = ev.id
//		} else {
//			self.settings.selectedEventId = nil
//		}
//	}
//	
////	func collectTeamPriceUpdates(watchedEvents:[Event]) {
////		// load data for prices at each event
////		// creates 3 wrapped funcs for each event
////
////		let topLvlPath = self.eventPricesPath
////		let _ = RealtimeUtil.getDbConnection(path: topLvlPath).observe(.childAdded, with: self.newTeamPricesReceived)
////
////		for e in watchedEvents {
////			let pricePath = topLvlPath + "/" + e.id
//////			print("watching price updates at \(pricePath)")
////			RealtimeUtil.observeModifyDelete(path: pricePath
//////				, added: wrappedDataObserver(eventID: e.id, f: self.teamPriceAdded)
////				, changed: wrappedDataObserver(eventID: e.id, entityChangeType:.updated)
////				, deleted: wrappedDataObserver(eventID: e.id, entityChangeType: .deleted)
////			)
////		}
////	}
//}
//
//
//extension TeamPricesApi {
//	
////	fileprivate func newTeamPricesReceived(ds:DataSnapshot) -> Void {
////		let eventID = ds.key
////		// FIXME:  confirm this new Event has also loaded
////
////		guard let allTeams = ds.value as? [String:[String:Double]]
////		else { print("Err in team prices"); return}
////
////		let allPrices = TeamPrice.initialPricesForEvent(data: allTeams )
////		self._eventPriceWrapper.updateEvent(eventID: eventID, teamPrices: allPrices)
////	}
//	
////	private func wrappedDataObserver(eventID:String, entityChangeType:EntityChangeType) -> ((DataSnapshot) -> Void) {
////
////		return { (ds:DataSnapshot) -> Void in
////			guard let teamPrice = TeamPrice(snapshot:ds)
////			else {
////				print("Err:  teamPriceUpdate failed for \(entityChangeType.rawValue) in \(eventID)")
////				return
////			}
////			// call the func that tracks all team prices
////			self._eventPriceWrapper.updateEvent(eventID: eventID, teamPrices: [teamPrice])
////			switch entityChangeType {
////	//			case .addded:
////	//
////	//			case .updated:
////	//
////				case .deleted:
////					if teamPrice.price < 0.01 {
////						// team is now worthless;  notify subscribers
////						NotificationEvent.teamValueToZero.post(userInfo: [teamPrice.teamId: teamPrice] )
////				}
////				default:
////					print("")
////					self.notifyDelegateOfNewData(teamPrice:teamPrice)
////			}
////		}
////	}
//	
//	private func notifyDelegateOfNewData(teamPrice:TeamPrice) {
//		print("just got notification of price change for team \(teamPrice.teamId)")
//		if let cd = self.changeDelegate {
//			cd.teamPriceChange(teamPrice:teamPrice)
//		} else {
//			print("Err:  no teamPriceChange delegate in place")
//		}
//		
//		// must have both delegate & team set for us to notify anyone except AppState.shared
//		guard let oneTeamDel = self.oneTeamChangeDelegate, let oneTeam = self.oneObservedTeam, teamPrice.teamId == oneTeam.id
//		else {	// either oneTeam delegate is not assigned or it's not for this team
//			return
//		}
//		// notify the BuySell VC that price is changing for the equity in play
//		oneTeamDel.teamPriceChange(teamPrice: teamPrice)
//	}
//	
//	private func filteredBySource() -> [TeamPrice] {
//		print("Ticker set to:  \(settings.source.rawValue)")
//		switch settings.source {
//		case .allEvents:
//			return _allTeamPrices
//		case .selectedEvent:
//			if let selectedEventId = settings.selectedEventId
//				, _eventPriceWrapper.countFor(eventID: selectedEventId) > 0
//			{
//				return _eventPriceWrapper.pricesFor(eventID: selectedEventId)
//			} else {
//				print("Err:  Ticker set to use selectedEvent but no prices found")
//				return _allTeamPrices
//			}
//		case .portfolio:
//			return _allTeamPrices
//		case .watchList:
//			return _allTeamPrices
//			//		default:
//			//			return { _ in true }
//		}
//	}
//}


// old code

//private func notifyDelegateWhenPricesLoaded() {
//	// teamPriceDataLoaded
//	if let cd = self.changeDelegate {
//		cd.teamPriceDataLoaded()
//	}
//}


// supporting functions
//private func getAllTeamPrices() -> Promise<[String:[String: [String:Double]]]> {
//	// EventID is top key;  TeamId is next key; final dict are the TeamPrice change vals
//	return RealtimeUtil.dataForNode(path: self.eventPricesPath)
//}
//
//func loadOnce(teams:[Team]) {
//	// read teamPrices for 1st time
//	var eventPrices:[EventPrices] = []
//
//	self.getAllTeamPrices().then { dictOfDicts -> Void in
//		// starting at event level
//		for (eventId, teamNumsDict) in dictOfDicts {
//			// now walk thru each TeamPrice
//			var teamPriceListForEvent = [String: TeamPrice]()
//			for (teamId, teamNums) in teamNumsDict {
//				teamPriceListForEvent[teamId] = TeamPrice(teamId:teamId, data:teamNums)
//			}
//			eventPrices.append( EventPrices(eventId: eventId, teamsDict: teamPriceListForEvent))
//			// fyi you could also build _masterDict here
//		}
//		print("Init:  Loading all Team-Prices")
//		var count = 0
//		if let ep = eventPrices.first {
//			count = ep.teamsDict.count
//		}
//		print("found \(eventPrices.count) Events.  1st event has \(count) teams")
//
//		// Teams w no price are not trading & not relevant
//		//			self.createPricesForMissedTeams(allTeams:teams, eventPrices:eventPrices)
//
//		self._pricesByEvent = eventPrices
//		self.notifyDelegateWhenPricesLoaded()
//		}.catch(execute: {err in
//			print("Err: Team Prices failed to load!! \(err.localizedDescription)")
//		})
//}
//
//func createPricesForMissedTeams(allTeams:[Team], eventPrices:[EventPrices]) {
//	// NIU
//	// teams with no price can still be added to the ticker??
//
//	func getEmptyTeamPrice(team:Team) -> TeamPrice {
//		// currently returns a mock to id missing recs
//		let price = 3.21	// drand48() * 5.28
//		let delta = -0.54	// drand48() * 0.99
//		return TeamPrice(currentPrice: price, recentChange: delta, teamId: team.shortName)
//	}
//
//	var newEventPrices = eventPrices
//	let teamsDict = allTeams.groupedBy()	// dict keyed by EventID
//
//	let currEventIds = eventPrices.map{ $0.eventId}
//	let eventIdsSet:Set<String> = Set(currEventIds)
//	for (evId, evTeams) in teamsDict {
//		var eventPriceIdx:Int = 0
//		if !eventIdsSet.contains(evId) {
//			newEventPrices.append(EventPrices(eventId: evId, teamsDict: [:]))
//			eventPriceIdx = newEventPrices.count - 1
//		} else {
//			eventPriceIdx = currEventIds.index(where: {$0 == evId})!
//		}
//		var origEvtPrc = newEventPrices[eventPriceIdx]
//		for t in evTeams {
//			if !origEvtPrc.contains(teamId: t.id) {
//				origEvtPrc.replaceTeamPrice(teamPrice: getEmptyTeamPrice(team: t))
//			}
//		}
//		newEventPrices[eventPriceIdx] = origEvtPrc
//	}
//
//	self._pricesByEvent = newEventPrices
//}



