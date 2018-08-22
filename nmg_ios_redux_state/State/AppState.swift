/*
App state divided into the following categories:

	entityRecs
	curEventState  (game & team recs; global to all users)
	pricesState (team price state)
	userAndSettingsState (current app context)
	accountState
	portfolioState

*/

import ReSwift

struct AppState: StateType, Equatable {
	/*  fundamental (flat & non-complex) state for entire app is nested under here
		it's important that this state remain immutable (structs)
		and simple/easy to update by reducers
	*/
	
	// entityRecs keeps copies of Events, Games, Teams, WatchLists
	let entityRecs: CoreEntityRepoState
	// related IDs for current event selected by the user
	let curEventState:CurrentEventState
	// pricesState keeps copies of most recent teamPrice values
	let pricesState: PricesState
	let userAndSettingsState: SettingsState	// includes the user
	let accountState: AccountState
	// portfolioState keeps copies of user ownership positions
	let portfolioState: PortfolioState
	let notificationState: NotificationState	// push msgs etc
//	let chatState: ChatState
//	let leaderboardState: LeaderboardState
}


//struct ChatState: StateType, Equatable {
//	
//}
//
//struct LeaderboardState: StateType, Equatable {
//	
//}


//so I have several other singletons (see ViewStateApisRO)
//that SUBSCRIBE to entityRecs and calc/update the more complex state
//needed by our Views;
//in conventional ReSwift, the views subscribe directly to the store
//in our implementation, they subscribe to the store to get change events
//but when they need SPECIFIC data, they request it from the above singletons
//that won't work because subscriber-callback order is not guaranteed
//and the view could get called BEFORE the singleton is updated
//so we need to implement a subscriber pattern on the ViewStateApisRO
//and let the views subscribe to those
