//
//  StateValueProto.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/14/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation


protocol StateValueProto {
	// any model object that holds a record
	var id:String {get}
}

extension StateValueProto {
	// return the struct name of the model instance
	func typeAsString() -> String {
		// return the class name
		return String(describing: Self.self)
	}
}
