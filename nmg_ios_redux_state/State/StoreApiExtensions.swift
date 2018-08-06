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
	*/
	
	func getLatest<R:StateObj>(id recID:String) -> R? {
		return (self.state as? AppState)?.entityRecs.getLatest(id:recID)
	}
	
	func listByType<R:StateObj>() -> [R] {
		return (self.state as? AppState)?.entityRecs.listByType() ?? []
	}
}
