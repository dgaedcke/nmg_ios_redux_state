//
//  ActionHierarchy.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/16/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//


Score Trader Actions
		STAct is the top most struct in which all enums are defined/scoped

		Our actions DO NOT map 1-1 to reducers or areas of state
		because some actions affect multiple areas of the total state-tree


Types of actions are:

	EventEvent:
		Any change in state of an event/tournament  (games, prices, points, start, end, etc)
		Comes from server (usually via Firebase listeners) related to PUBLIC/global data
	
	AppModeAction:
		Any change user makes in configuration of the app including changes to:
		Current Event; currency in use; data-source for ticker; sign-out, etc
	
	FinancialAction:
		All changes to Account balance or portfolio;  includes any action related to:
		Adding or removing money from account
		Buying or selling equities
		Changing banking configuration
	
	NotificationAction:
		All changes related to external input (push-notifications, private (user) firebase observers)


