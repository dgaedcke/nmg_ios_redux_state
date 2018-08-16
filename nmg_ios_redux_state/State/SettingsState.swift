//
//  SettingsState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/16/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


struct SettingsState: StateType, Equatable {
	/*  user app settings including:
	currency (token or coin) mode
	ticker settings
	security/privacy config
	any style customization
	*/
	
	var coinTokenRefillPolicy:Int = 0	// how to put money into account
	var balanceLiquidatePolicy:Int = 0	// how to take money out of account
}
