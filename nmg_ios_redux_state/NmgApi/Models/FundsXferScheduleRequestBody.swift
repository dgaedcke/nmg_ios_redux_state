//
// FundsXferScheduleRequestBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** When to move the funds */

public struct FundsXferScheduleRequestBody: Codable {

    /** effectiveDttm to transfer */
    public var effectiveDttm: Date

    public init(effectiveDttm: Date) {
        self.effectiveDttm = effectiveDttm
    }


}

