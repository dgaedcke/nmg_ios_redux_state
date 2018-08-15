//
//  CoreStateRepo.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/2/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation

// CoreEntityRepo below:




private enum ModelType {
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
	
//	func markAs(stable unchanged:Bool = true) -> CoreEntityRepo {
//		var new = self
//		new.stateHaschanged = !unchanged
//		return new
//	}
	
	func listByType<R:StateValueProto>() -> [R] {
		// return list of all Games/etc
		// FIX ME:
		let prefix = String(describing: R.self)
//		return objMap.filter( { (k, _) in return k.hasPrefix(prefix) }).values as [R]
		return []
	}
	
	func getLatest<R:StateValueProto>(id recID:String) -> R? {
		let tblIdx = String(describing: R.self)	// .hashValue
		let key = "\(tblIdx)-" + recID
//		print(key)
		guard let box = objMap[key] else { return nil }
		return box.valueFromBox()
	}
	
	static func == (lhs: CoreEntityRepo, rhs: CoreEntityRepo) -> Bool {
		return lhs.lastUpdatedDtTm == rhs.lastUpdatedDtTm
	}
}


