import ReSwift


func appReducer(action: Action, state: AppState?) -> AppState {
	// 
	return AppState(
		// coreEntityReducer just tracks latest state of ALL (ie global) recs (model instances)
		// Events, Games, Teams, Prices, etc
		entityRecs: coreEntityReducer(action: action, state: state?.entityRecs),
		// keeps list of model-instance keys that pertain to the current selected Event
		curEventState: eventStateReducer(action: action, state: state?.curEventState, entityRecs: state?.entityRecs, pricesState: state?.pricesState),
		// keeps all team prices
		pricesState: priceReducer(action: action, state: state?.pricesState),
		// tracks user settings
		userAndSettingsState: settingsReducer(action:action, state: state?.userAndSettingsState),
		// settings for moving $$ in and out of the account
		accountState: accountBankReducer(action: action, state: state?.accountState),
		// user holdings
		portfolioState: portfolioReducer(action: action, state: state?.portfolioState),
		// push notification state
		notificationState: notificationReducer(action: action, state: state?.notificationState)
	)
}

// or another pattern

//struct MainAppReducer: Reducer<AppState> {
////	let apiManager = MarvelAPIManager()
//	
//	func handleAction(action: Action, state: AppState?) -> AppState {
//		return appReducer(action: action, state: state)
//	}
//	
//}


// eventsState tracks games & teams & tradability
//eventsState: eventReducer(action: action, state: state?.eventsState),
