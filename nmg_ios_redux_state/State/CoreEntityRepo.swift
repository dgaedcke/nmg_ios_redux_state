//
//  CoreStateRepo.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/2/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation

// CoreEntityRepo below:

protocol StateObj {
	var id:String {get}
}

private enum ModelType {
	case sport(Sport)
	case event(Event)
	//	case game(Game)
	//	case team(Team)
	//	case discriminator(Dimension)
	case unknown(Int?)
	
	
	func valueFromBox<R:StateObj>() -> R? {
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
	
	static func box(rec: StateObj) -> ModelType {
		
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


struct CoreEntityRepo: Equatable {
	/*  abstract store for model records of many types
		ReSwift store is MUCH more efficient with equatable structs
		at some point after reducers run, store will check which parts of state
		have changed and only broadcast data to subscribers of CHANGED areas
		since this is a singleton, we need to manage our own dirty state
		via self.stateHaschanged
	*/
	static var shared = CoreEntityRepo()
	
	private var objMap = [String:ModelType]()
	private var stateHaschanged:Bool = true
	
	mutating func updateObj(rec:StateObj) {
		let box = ModelType.box(rec: rec)
		let key = box.fullKey(recID:rec.id)
		objMap[key] = box
		self.stateHaschanged = false
	}
	
	mutating func markAs(stable unchanged:Bool = true) {
		self.stateHaschanged = !unchanged
	}
	
	func listByType<R:StateObj>() -> [R] {
		// return list of all Games/etc
		// FIX ME:
		let prefix = String(describing: R.self)
//		return objMap.filter( { (k, _) in return k.hasPrefix(prefix) }).values as [R]
		return []
	}
	
	func getLatest<R:StateObj>(id recID:String) -> R? {
		let tblIdx = String(describing: R.self)	// .hashValue
		let key = "\(tblIdx)-" + recID
//		print(key)
		guard let box = objMap[key] else { return nil }
		return box.valueFromBox()
	}
	
	private init() {
		// prevent new instances
	}
	
	static func == (lhs: CoreEntityRepo, rhs: CoreEntityRepo) -> Bool {
		//
		return CoreEntityRepo.shared.stateHaschanged
	}
}


