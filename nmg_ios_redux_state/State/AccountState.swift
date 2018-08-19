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

	var watchList = Set<AssetKey>()
}


extension AccountState {
	// public api
	
	func debitCredit() -> AccountState {
		return self
	}
	
	func toggleWatchList(assetKey:AssetKey) -> AccountState {
		var new = self
		if self.watchList.contains(assetKey) {
			new.watchList.remove(assetKey)
		} else {
			new.watchList.insert(assetKey)
		}
		return new
	}
	
	func isWatched(assetKey:AssetKey) -> Bool {
		return self.watchList.contains(assetKey)
	}
}
