/*
App state divided into the following categories:

	Event  (game & team changes; global to all users)
	Prices (team price state)
	Settings (current app context)
	Banking
	Portfolio

*/

import ReSwift

struct AppState: StateType {

	let eventsState: EventState
	let pricesState: PricesState
	let userAndSettingsState: SettingsState	// includes the user
	let bankingState: BankingState
	let portfolioState: PortfolioState
	let notificationState: NotificationState	// push msgs etc
//	let chatState: ChatState
//	let leaderboardState: LeaderboardState
}

struct PricesState: StateType {
	/*  team prices
		all GLOBAL data (same for all users)
	*/
	
}

struct SettingsState: StateType {
	/*  user app settings including:
		currency (token or coin) mode
		ticker settings
		security/privacy config
		any style customization
	*/
}

struct BankingState: StateType {
	/*  user account balances & config for adding/removing money
	*/
}

struct PortfolioState: StateType {
	
}

struct NotificationState: StateType {
	
}

struct ChatState: StateType {
	
}

struct LeaderboardState: StateType {
	
}
