//
// SubmitResponseBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Record Summary (default view) */

public struct SubmitResponseBody: Codable {

    /** Int 64 id */
    public var intID: Int64?
    /** Received Time */
    public var receivedTime: String
    /** String id */
    public var stringID: String?

    public init(intID: Int64?, receivedTime: String, stringID: String?) {
        self.intID = intID
        self.receivedTime = receivedTime
        self.stringID = stringID
    }


}

