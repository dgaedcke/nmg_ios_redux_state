//
//  OrderActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


struct OrderPlacedAction: Action {
	let assetKey: String
}


struct OrderCompletedAction: Action {
	let assetKey: String
}
