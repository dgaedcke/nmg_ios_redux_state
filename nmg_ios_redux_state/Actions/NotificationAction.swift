//
//  NotificationAction.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

extension STAct {
	
	enum Notification: Action {
		// All changes related to external input (push-notifications, private (user) firebase observers)
		
		case transferCompleted(STActDebitCreditDetails)
		case orderCompleted(STActDebitCreditDetails)
		case refillCompleted(STActDebitCreditDetails)
		case liquidationOccurred
		
		case setBalanceAlert(Int)	// set up account $$ threashold
		case receivedBalanceAlert(Int)  // notify user when acct. balance reaches threashold
	}
}
