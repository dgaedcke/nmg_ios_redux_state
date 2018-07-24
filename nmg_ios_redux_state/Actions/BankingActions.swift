//
//  BankingActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


enum StBankingAction: Action {
	/* everything about currency & account balances

	*/
	// transfers are buying/selling of currency/coins
	case transferStarted(DebitCreditDetails)
	case transferCompleted(DebitCreditDetails)
	// orders are buying selling of stock (team-equities)
	case orderStarted(DebitCreditDetails)
	case orderCompleted(DebitCreditDetails)
	
	case balanceLow(DebitCreditDetails)
	case refillStarted(DebitCreditDetails)
	case refillCompleted(DebitCreditDetails)
	
	struct DebitCreditDetails {
		// payload to describe a debit (decrease) or credit (increase) in user-acct balance
		let type:StCurrencyType
		let isDebit:Bool	// false if credit
		let quan:Int	// coins or tokens to add/sub from user account
	}
}

