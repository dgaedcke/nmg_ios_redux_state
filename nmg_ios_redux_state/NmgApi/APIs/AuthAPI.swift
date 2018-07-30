//
// AuthAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import PromiseKit



open class AuthAPI {
    /**
     basic auth
     
     - parameter int: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func authBasic(int: Int64, completion: @escaping ((_ data: BasicResponseBody?,_ error: Error?) -> Void)) {
        authBasicWithRequestBuilder(int: int).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     basic auth
     
     - parameter int: (body)  
     - returns: Promise<BasicResponseBody>
     */
    open class func authBasic( int: Int64) -> Promise<BasicResponseBody> {
        let (promise, resolver) = Promise<BasicResponseBody>.pending()
        authBasic(int: int) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     basic auth
     - GET /auth/basic
     - niu.
     - examples: [{contentType=application/json, example={
  "email" : "frieda_leannon@adamscollier.net",
  "id" : "Quam corrupti velit autem ut.",
  "issuer" : "Rerum sed quia recusandae porro rerum."
}}]
     
     - parameter int: (body)  

     - returns: RequestBuilder<BasicResponseBody> 
     */
    open class func authBasicWithRequestBuilder(int: Int64) -> RequestBuilder<BasicResponseBody> {
        let path = "/auth/basic"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: int)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<BasicResponseBody>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     jwt auth
     
     - parameter string: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func authJwt(string: String, completion: @escaping ((_ data: Bool?,_ error: Error?) -> Void)) {
        authJwtWithRequestBuilder(string: string).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     jwt auth
     
     - parameter string: (body)  
     - returns: Promise<Bool>
     */
    open class func authJwt( string: String) -> Promise<Bool> {
        let (promise, resolver) = Promise<Bool>.pending()
        authJwt(string: string) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     jwt auth
     - GET /auth/jwt
     - examples: [{contentType=application/json, example=true}]
     
     - parameter string: (body)  

     - returns: RequestBuilder<Bool> 
     */
    open class func authJwtWithRequestBuilder(string: String) -> RequestBuilder<Bool> {
        let path = "/auth/jwt"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: string)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Bool>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}