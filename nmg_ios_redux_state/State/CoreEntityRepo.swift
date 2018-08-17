//
//  CoreEntityRepo.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/2/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation


// CoreEntityRepo is a generic collection of model instances (db recs)
// we use it to hold latest copy of every rec received whether it's
// active (part of current user-selected event) or not

struct CoreEntityRepo: Equatable {	// , Hashable
	/*  abstract store for model records of many types
		ReSwift store is MUCH more efficient with equatable structs
		at some point after reducers run, store will check which parts of state
		have changed and only broadcast data to subscribers of CHANGED areas
		since this is a singleton, we need to manage our own dirty state
		via self.stateHaschanged
	*/
	
	private var objMap = [String:ModelType]()
	private var lastUpdatedDtTm = Date()
	
	func updateObj(rec:StateValueProto) -> CoreEntityRepo {
		var new = self
		let box = ModelType.box(rec: rec)
		let key = box.fullKey(recID:rec.id)
		new.objMap[key] = box
		new.lastUpdatedDtTm = Date()
		return new
	}
	
	func listByType<R:StateValueProto>() -> [R] {
		// return list of all Games/etc
		let prefix = String(describing: R.self)
		let filteredDict = objMap.filter({ $0.key.hasPrefix(prefix) })
		let recsAsArray = filteredDict.map { $0.value } // as? [ModelType]
		return recsAsArray.compactMap({ $0.valueFromBox() })
	}
	
	func listByTypeFiltered<R:StateValueProto>(by f: (R) -> Bool ) -> [R] {
		let recsAsArray:[R] = listByType()
		return recsAsArray.filter(f)
	}
	
	func getLatest<R:StateValueProto>(id recID:String) -> R? {
		let keyPrefix = String(describing: R.self)	// .hashValue
		let key = "\(keyPrefix)-" + recID
//		print(key)
		guard let box = objMap[key] else { return nil }
		return box.valueFromBox()
	}
	
	static func == (lhs: CoreEntityRepo, rhs: CoreEntityRepo) -> Bool {
		return lhs.lastUpdatedDtTm == rhs.lastUpdatedDtTm
	}
}


private enum ModelType {
	// box/wrapper for instances stored in CoreEntityRepo
	
	// Equatable
	
	//	static func == (lhs: ModelType, rhs: ModelType) -> Bool {
	//		guard let lr:StateValueProto = lhs.valueFromBox() as! StateValueProto
	//			, let rr:StateValueProto = rhs.valueFromBox()
	//		else { return false }
	//		return lr.id == rr.id
	//	}
	
	case sport(Sport)
	case event(Event)
	//	case game(Game)
	//	case team(Team)
	//	case discriminator(Dimension)
	case unknown(Int?)
	
	
	func valueFromBox<R:StateValueProto>() -> R? {
		//		return _(let rec) = self
		switch self {
		case .sport(let rec):
			return rec as? R
		case .event(let rec):
			return rec as? R
		default:
			return nil
		}
	}
	
	static func box(rec: StateValueProto) -> ModelType {
		
		switch rec {
		case let sp as Sport:
			return .sport(sp)
		case let sp as Event:
			return .event(sp)
			//		case let sp as Game:
			//			return .game(sp)
			//		case let sp as Team:
		//			return .team(sp)
		default:
			return unknown(0)
		}
	}
	
	func fullKey(recID:String) -> String {
		var typeIdx = "na"
		switch self {
		case .sport(_):
			typeIdx = String(describing: Sport.self)
		case .event(_):
			typeIdx = String(describing: Event.self)
		default:
			break
		}
		return typeIdx + "-" + recID
	}
}
