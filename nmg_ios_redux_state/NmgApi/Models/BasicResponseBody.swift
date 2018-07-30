//
// BasicResponseBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** BasicResponseBody result type (default view) */

public struct BasicResponseBody: Codable {

    /** User email */
    public var email: String?
    /** User ID */
    public var _id: String
    /** Token issuer */
    public var issuer: String?

    public init(email: String?, _id: String, issuer: String?) {
        self.email = email
        self._id = _id
        self.issuer = issuer
    }

    public enum CodingKeys: String, CodingKey { 
        case email
        case _id = "id"
        case issuer
    }


}

