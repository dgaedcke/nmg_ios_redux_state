//
// PortfolioHoldingResultMsgResponseBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Entities held in Account (default view) */

public struct PortfolioHoldingResultMsgResponseBody: Codable {

    /** assetKey */
    public var assetKey: String
    /** assetStatus */
    public var assetStatus: String
    /** execDtTm */
    public var execDtTm: String
    /** price */
    public var price: Int64
    /** shares */
    public var shares: Int64
    /** trans ID */
    public var transID: Int64

    public init(assetKey: String, assetStatus: String, execDtTm: String, price: Int64, shares: Int64, transID: Int64) {
        self.assetKey = assetKey
        self.assetStatus = assetStatus
        self.execDtTm = execDtTm
        self.price = price
        self.shares = shares
        self.transID = transID
    }


}

