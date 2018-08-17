//
//  StoreApiExtensions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/6/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

extension Store {
	/*  this is the public read/pull API for the full app state
		most state/data should come via subscriptions
		but if you just need one record, you can read it from here
		rather than iterating through list of all games
	
	this is an anti-pattern;  should use another RO API for this
	but won't no-op this until I have that other pattern established
	*/
	
	func getLatest<R:StateValueProto>(id recID:String) -> R? {
		return (self.state as? AppState)?.entityRecs.getLatest(id:recID)
	}
	
	func listByType<R:StateValueProto>() -> [R] {
		return (self.state as? AppState)?.entityRecs.listByType() ?? []
	}
	
	func listByTypeFiltered<R:StateValueProto>(by filter: (StateValueProto) -> Bool ) -> [R] {
		return (self.state as? AppState)?.entityRecs.listByTypeFiltered(by:filter) ?? []
	}
}
