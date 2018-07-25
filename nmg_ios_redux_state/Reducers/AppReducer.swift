import ReSwift


func appReducer(action: Action, state: AppState?) -> AppState {
	// 
	return AppState(
		eventsState: eventReducer(action: action, state: state?.eventsState),
		pricesState: priceReducer(action: action, state: state?.pricesState),
		userAndSettingsState: settingsReducer(action:action, state: state?.userAndSettingsState),
		bankingState: bankingReducer(action: action, state: state?.bankingState),
		portfolioState: portfolioReducer(action: action, state: state?.portfolioState),
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
