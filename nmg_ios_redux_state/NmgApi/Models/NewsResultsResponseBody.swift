//
// NewsResultsResponseBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** News response (default view) */

public struct NewsResultsResponseBody: Codable {

    public enum NewsEntityType: String, Codable { 
        case app = "app"
        case event = "event"
        case game = "game"
        case team = "team"
    }
    /** caption */
    public var caption: String
    /** detail */
    public var detail: String
    /** entityID */
    public var entityID: String
    /** newsEntityType */
    public var newsEntityType: NewsEntityType
    /** parentEntityID */
    public var parentEntityID: String
    /** postedDtTm */
    public var postedDtTm: String

    public init(caption: String, detail: String, entityID: String, newsEntityType: NewsEntityType, parentEntityID: String, postedDtTm: String) {
        self.caption = caption
        self.detail = detail
        self.entityID = entityID
        self.newsEntityType = newsEntityType
        self.parentEntityID = parentEntityID
        self.postedDtTm = postedDtTm
    }


}

