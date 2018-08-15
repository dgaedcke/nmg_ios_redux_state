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
	/*  fundamental (flat & non-complex) state for entire app is nested under here
		it's important that this state remain immutable (structs)
		and simple/easy to update by reducers
		so I have several other singletons (see ViewStateApisRO)
		that SUBSCRIBE to entityRecs and calc/update the more complex state
		needed by our Views;
		in conventional ReSwift, the views subscribe directly to the store
		in our implementation, they subscribe to the store to get change events
		but when they need SPECIFIC data, they request it from the above singletons
		that won't work because subscriber-callback order is not guaranteed
		and the view could get called BEFORE the singleton is updated
		so we need to implement a subscriber pattern on the ViewStateApisRO
		and let the views subscribe to those
	*/
	// entityRecs keeps copies of Events, Games, Teams, WatchLists
	var entityRecs: CoreEntityRepo
	// pricesState keeps copies of most recent teamPrice values
	let pricesState: PricesState
	let userAndSettingsState: SettingsState	// includes the user
	let bankingState: BankingState
	// portfolioState keeps copies of user ownership positions
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
