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

	override func viewDidLoad() {
		super.viewDidLoad()

		store.subscribe(self) { $0.select { state in state.userAndSettingsState } }
	}

}


extension ViewController: StoreSubscriber {
	
	func newState(state: SettingsState) {

//		switch state {
//		case .loading:
//			break
//		case let .finished(films):
//
//		}
	}
}
