//
// WithdrawFundsRequestBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct WithdrawFundsRequestBody: Codable {

    /** currency source or destination */
    public var accountId: String?
    public var atts: FundsXferScheduleRequestBody?
    /** currency Type */
    public var currencyType: String?
    /** currency quantity; negative for withdrawl */
    public var nmgDollars: Float?

    public init(accountId: String?, atts: FundsXferScheduleRequestBody?, currencyType: String?, nmgDollars: Float?) {
        self.accountId = accountId
        self.atts = atts
        self.currencyType = currencyType
        self.nmgDollars = nmgDollars
    }


}

