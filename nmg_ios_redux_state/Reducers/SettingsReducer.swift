//
//  SettingsReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func settingsReducer(action: Action, state: SettingsState?) -> SettingsState {
	let state = state ?? SettingsState()
	
	switch action {
	case let newCurrency as CurrencyModeChangeAction:
		break
	default:
		break
	}
	
	return state
}
