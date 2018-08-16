//
//  FinancialActions.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 7/24/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import ReSwift

extension STAct {
	
	enum Financial: Action {
		/* All changes to Account balance or portfolio;
			everything about currency, account & portfolio
			see details in ActionHierarchy.swift
		*/
		// transfers are buying/selling of currency/coins
		case transferStarted(STActDebitCreditDetails)

		
		// orders are buying selling of stock (team-equities)
		case orderStarted(STActDebitCreditDetails)

		
		case balanceLow(STActDebitCreditDetails)
		case refillStarted(STActDebitCreditDetails)
		
		

		
		// portfolio
		case orderPlaced(STActPortfolioActionDetails)
		
		

	}
}
