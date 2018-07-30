//
// UpdateRequestBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct UpdateRequestBody: Codable {

    /** avatarUrl */
    public var avatarURL: String?
    /** Birthday */
    public var DOB: String?
    /** Email Address */
    public var email: String?
    /** @handle */
    public var handle: String?
    /** Phone number in string format */
    public var phone: String?
    /** Sex */
    public var sex: String?

    public init(avatarURL: String?, DOB: String?, email: String?, handle: String?, phone: String?, sex: String?) {
        self.avatarURL = avatarURL
        self.DOB = DOB
        self.email = email
        self.handle = handle
        self.phone = phone
        self.sex = sex
    }

    public enum CodingKeys: String, CodingKey { 
        case avatarURL = "AvatarURL"
        case DOB
        case email = "Email"
        case handle = "Handle"
        case phone = "Phone"
        case sex = "Sex"
    }


}
