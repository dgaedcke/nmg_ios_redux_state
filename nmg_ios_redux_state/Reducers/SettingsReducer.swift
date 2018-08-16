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
	
	guard let specAction = action as? STAct.AppMode
	else { return state }
	
	switch specAction {
	case .changeCurrencyMode(let newCurrencyType):
		break
	default:
		break
	}
	
	return state
}
