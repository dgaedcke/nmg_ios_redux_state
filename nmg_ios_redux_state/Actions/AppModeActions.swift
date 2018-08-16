//
//  AppModeActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


extension STAct {
	//  Any change user makes in configuration of the app including changes to:
	//	Current Event; currency in use; data-source for ticker; sign-out, etc

	enum AppMode: Action {
		// any user, local config settings
		
		case changeCurrencyMode(StCurrencyType)
		case changeCurrentEvent(RDXTypes.EventID)	// eventID
		case changeTickerSource(RDXTypes.EventID) // eventID
		//

	}
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
