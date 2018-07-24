//
//  PortfolioActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/20/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


enum StPortfolioAction: Action {
	case orderPlaced(PortfolioActionDetails)
	case orderCompleted(PortfolioActionDetails)
	case liquidationOccurred
	
	struct PortfolioActionDetails {
		// payload to describe change in user-holdings
		let assetKey:String
		let isBuy:Bool	// false if sell
		let shares:Int	// coins or tokens to add/sub from user account
	}
}

