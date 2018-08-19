//
//  TeamGameEventKey.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 6/11/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

import Foundation

fileprivate let K_DELIM = ">"	// vital to match key construction rule on server
fileprivate let K_UNSET = "unset"

struct AssetKey: Codable, Hashable, Equatable {
	// all String model keys will be lowercase
	
	// should not change these after object constructed
	private var _teamId:String = K_UNSET
	private var _eventId:String = K_UNSET
	private var _isInvalid:Bool = false
	
	var teamId:String {
		return _teamId
	}
	
	var eventId:String {
		return _eventId
	}
	
	var id:String {
		// must match server
		return "\(_teamId)\(K_DELIM)\(_eventId)".lowercased()
	}
	
	var key:String {
		return id
	}
	
	init(teamId:String, eventId:String) {
		// this is the master init that others should delegate to
		self._teamId = teamId
		self._eventId = eventId
		if eventId.count < 3 {
			AssetKey.logError(teamId: teamId)
			self._isInvalid = true
		}
	}
	
	private static func logError(teamId:String) {
		let msg = "Tried to construct asset key on \(teamId) with no event"
		print(msg)
//		AppEvents.log(severity: .Error, entity: String(describing: self), msg: msg)
	}
	
	init (keyString:String) {
		let arr = keyString.components(separatedBy: K_DELIM)
		let missingGame = arr.count == 2
		
		let _teamId = arr[0]
		let _eventId = arr[missingGame ? 1 : 2 ]
		
		self.init(teamId: _teamId, eventId: _eventId)
	}
	
	static func makeFrom(game:Game) -> (AssetKey, AssetKey?) {
		// use a game to create asset key's for each team
		let favAK = AssetKey(teamId: game.favTeamId, eventId: game.eventId)
		guard let underID = game.underTeamId
		else {
			return (favAK, nil)
		}
		let underAK = AssetKey(teamId: underID, eventId: game.eventId)
		return (favAK, underAK)
	}
	
	static func isInvalid(key:String) -> Bool {
		
		let ak = AssetKey(keyString: key)
//		guard AppState.shared.allEvents.filter( {$0.id == ak.eventId}).count > 0
//			else { return true }
		return false
	}
	
	static func fromKeyString(keyString:String) -> AssetKey {
		return AssetKey(keyString:keyString)
	}
	
	static let seed = AssetKey(teamId: K_UNSET, eventId: K_UNSET)
}

func ==(lhs: AssetKey, rhs: AssetKey) -> Bool {
	return lhs.id == rhs.id
}

