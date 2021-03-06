//
// SummaryInternalErrorResponseBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** SummaryInternalErrorResponseBody result type (default view) */

public struct SummaryInternalErrorResponseBody: Codable {

    /** ID is a unique identifier for this particular occurrence of the problem. */
    public var _id: String
    /** Message is a human-readable explanation specific to this occurrence of the problem. */
    public var message: String
    /** Name is the name of this class of errors. */
    public var name: String
    /** Is the error temporary? */
    public var temporary: Bool
    /** Is the error a timeout? */
    public var timeout: Bool

    public init(_id: String, message: String, name: String, temporary: Bool, timeout: Bool) {
        self._id = _id
        self.message = message
        self.name = name
        self.temporary = temporary
        self.timeout = timeout
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case message
        case name
        case temporary
        case timeout
    }


}

