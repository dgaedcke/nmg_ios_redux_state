//
//  BankingReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func bankingReducer(action: Action, state: BankingState?) -> BankingState {
	let state = state ?? BankingState()
	
	switch action {
	case let newCurrency as CurrencyModeChangeAction:
		break
	default:
		break
	}
	
	return state
}
