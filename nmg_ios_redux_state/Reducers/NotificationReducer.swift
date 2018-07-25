//
//  NotificationReducer.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/23/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

func notificationReducer(action: Action, state: NotificationState?) -> NotificationState {
	let state = state ?? NotificationState()
	
	guard let specAction = action as? StNotificationAction
		else { return state }
	
	switch specAction {
//	case let newCurrency as CurrencyModeChangeAction:
//		break
	default:
		break
	}
	
	return state
}
