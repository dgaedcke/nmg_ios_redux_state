//
//  PriceActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift


enum StPriceAction: Action {
	// 
	case priceIncreased(String)	// assetKey
	case priceDecreased(String) // assetKey
	case priceToZero(String)	// teamID (spans many events when team loses/eliminated)
	
}
