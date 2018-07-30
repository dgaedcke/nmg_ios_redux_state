//
//  PriceActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


enum StPriceAction: Action {
	// from DB
	case priceUpdated(TeamPrice)
	
	// from reducer
	case priceIncreased(TeamPrice)	// assetKey
	case priceDecreased(TeamPrice) // assetKey
	case priceToZero(NTA.TeamID)	// teamID (spans many events when team loses/eliminated)
	
}
