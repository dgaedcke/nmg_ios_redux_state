//
//  SharedActionPayloads.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/16/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation


struct STActDebitCreditDetails {
	// payload to describe a debit (decrease) or credit (increase) in user-acct balance
	let type:StCurrencyType
	let isDebit:Bool	// false if credit
	let quan:Int	// coins or tokens to add/sub from user account
}

struct STActPortfolioActionDetails {
	// payload to describe change in user-holdings
	let assetKey:String
	let isBuy:Bool	// false if sell
	let shares:Int	// coins or tokens to add/sub from user account
}
