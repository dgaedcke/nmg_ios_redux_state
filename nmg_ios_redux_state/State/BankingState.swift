//
//  BankingState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

struct BankingState: StateType, Equatable {
	/*  user account balances & config for adding/removing money
	*/
	let coinBalance:Int
	let tokenBalance:Int
	let refillPolicy:Int	// how to put money into account
	let liquidatePolicy:Int	// how to take money out of account
}
