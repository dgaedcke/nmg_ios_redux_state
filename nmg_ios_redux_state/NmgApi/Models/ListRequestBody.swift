//
// ListRequestBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ListRequestBody: Codable {

    /** eventID */
    public var eventID: String?
    /** gameID */
    public var gameID: String?
    /** teamID */
    public var teamID: String?

    public init(eventID: String?, gameID: String?, teamID: String?) {
        self.eventID = eventID
        self.gameID = gameID
        self.teamID = teamID
    }


}

