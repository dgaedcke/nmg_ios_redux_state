//
//  ViewController.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/19/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import UIKit
import ReSwift


class ViewController: UIViewController {

	var currentGameID = "123"	// set this from the segue and the VDL will handle getting the needed data
	
	// gameTeamViewModel is the VM to expose all properties
	// this view might need to display
	var gameTeamViewModel:GameTeamViewModel = GameTeamViewModel.seed()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		store.subscribe(self) { (subscription) in
			subscription.select { (state) in
				// subscribe to a subset so I only get notified when necessary
				// but then use the WHOLE state below to construct GameTeamViewModel
				
				// my select function ALWAYS returns the rec I care about (optional is moot)
				// whether it has changed or not
				// and then AFTER that, ReSwift will check equatable on that one rec/value
				// and ONLY call newState if it has changed
				
				// signature down in "func newState(state: Game?)" dictates what can/must be returned here
				// note that we bail out of newState if it gets sent nil
				return state.entityRecs.getLatest(id: self.currentGameID)
			}
		}
	}
	
	func redrawAfterStateChange() {
		// use self.gameTeamViewModel to update this UI
		
	}
	
	deinit {
		store.unsubscribe(self)
	}

}


extension ViewController: StoreSubscriber {
	
	func newState(state: Game?) {
		
		guard let game = state else { return }
		// subscribed to sub-state
		// only re-render if VC's owned recs have changed
		if let appState = store.state
			// an example of reading directly from the store.state struct
			, let readLatestTeamWhenGameChanges:Team = store.getLatest(id: game.favTeamId) {
			
			// reconstruct the VM based on latest data
			self.gameTeamViewModel =  GameTeamViewModel(state: appState, gameID: self.currentGameID, teamID: readLatestTeamWhenGameChanges.id)
			self.redrawAfterStateChange()
		}
	}
}
