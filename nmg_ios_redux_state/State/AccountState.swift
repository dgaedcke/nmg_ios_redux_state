//
//  BankingState.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

struct AccountState: StateType, Equatable {
	/*  user account balances & config for adding/removing money
	*/
	var coinBalance:Int = 0
	var tokenBalance:Int = 0
	var cashBalance:Int = 0

}
