//
//  AccountBankReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func accountBankReducer(action: Action, state: AccountState?) -> AccountState {
	
	let state = state ?? AccountState()
	
	switch action as? STAct.Financial {
//	case let newCurrency as CurrencyModeChangeAction:
//		break
	default:
		break
	}
	
	switch action as? STAct.Notification {
		//	case let newCurrency as CurrencyModeChangeAction:
	//		break
	default:
		break
	}
	
	return state
}
