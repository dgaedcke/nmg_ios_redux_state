//
// DepositFundsResponseBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** DepositFundsResponseBody result type (default view) */

public struct DepositFundsResponseBody: Codable {

    /** cashOnHand */
    public var cashOnHand: Float
    /** totalValue */
    public var totalValue: Float

    public init(cashOnHand: Float, totalValue: Float) {
        self.cashOnHand = cashOnHand
        self.totalValue = totalValue
    }


}

