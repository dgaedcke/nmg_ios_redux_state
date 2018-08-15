//
//  ScopedSubscriberProto.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/14/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation


protocol ScopedSubscriberProto: AnyObject {
	// any view or VC that wants to subscribe to a limited set of record changes
	//  when the VC subscribes (or updates subscription)
	// it's important that he passes the Observer a list of tuples
	// [ ("Team", "123"), ("Game", "abc") ] to identify recs he cares about
	// list of tuples defines "relevant" data
	
	// called whenever relevant data has changed
	func scopedStateChangeCallback(rec: StateValueProto)
}
