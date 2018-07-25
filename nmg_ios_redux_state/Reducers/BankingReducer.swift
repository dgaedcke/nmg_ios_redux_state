//
//  BankingReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func bankingReducer(action: Action, state: BankingState?) -> BankingState {
	let state = state ?? BankingState(coinBalance: 0, tokenBalance: 0, refillPolicy: 0, liquidatePolicy: 0)
	
	guard let specAction = action as? StBankingAction
		else { return state }
	
	switch specAction {
//	case let newCurrency as CurrencyModeChangeAction:
//		break
	default:
		break
	}
	
	return state
}
