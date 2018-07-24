//
//  SettingsActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

enum StCurrencyType {
	case coin
	case token
}


enum StSettingsAction: Action {
	// any user, local config settings
	
	case changeCurrencyMode(StCurrencyType)
	case changeCurrentEvent(String)	// eventID
	case changeTickerSource(String) // eventID
	//
	case setBalanceAlert(Int)	// set up account $$ threashold
	case receivedBalanceAlert(Int)  // notify user when acct. balance reaches threashold
}






//struct CurrencyModeChangeAction: Action {
//	let assetKey: CurrencyMode = .token
//
//
//}
//
//
//struct TickerChangeAction: Action {
//	let assetKey: String
//}
