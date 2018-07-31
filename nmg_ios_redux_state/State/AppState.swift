/*
App state divided into the following categories:

	Event  (game & team changes; global to all users)
	Prices (team price state)
	Settings (current app context)
	Banking
	Portfolio

*/

import ReSwift

struct AppState: StateType, Equatable {

	let eventsState: EventsState
	let pricesState: PricesState
	let userAndSettingsState: SettingsState	// includes the user
	let bankingState: BankingState
	let portfolioState: PortfolioState
	let notificationState: NotificationState	// push msgs etc
//	let chatState: ChatState
//	let leaderboardState: LeaderboardState
}

struct SettingsState: StateType, Equatable {
	/*  user app settings including:
		currency (token or coin) mode
		ticker settings
		security/privacy config
		any style customization
	*/
}



struct PortfolioState: StateType, Equatable {
	
}

struct NotificationState: StateType, Equatable {
	
}

struct ChatState: StateType, Equatable {
	
}

struct LeaderboardState: StateType, Equatable {
	
}
