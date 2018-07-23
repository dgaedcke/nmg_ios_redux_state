//
//  SettingsActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


struct CurrencyModeChangeAction: Action {
	let assetKey: CurrencyMode = .token
	
	enum CurrencyMode {
		case coin
		case token
	}
}


struct TickerChangeAction: Action {
	let assetKey: String
}
