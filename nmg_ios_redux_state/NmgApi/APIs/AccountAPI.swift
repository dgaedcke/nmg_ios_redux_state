//
// AccountAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import PromiseKit



open class AccountAPI {
    /**
     depositFunds account
     
     - parameter depositFundsRequestBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountDepositFunds(depositFundsRequestBody: DepositFundsRequestBody, completion: @escaping ((_ data: DepositFundsResponseBody?,_ error: Error?) -> Void)) {
        accountDepositFundsWithRequestBuilder(depositFundsRequestBody: depositFundsRequestBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     depositFunds account
     
     - parameter depositFundsRequestBody: (body)  
     - returns: Promise<DepositFundsResponseBody>
     */
    open class func accountDepositFunds( depositFundsRequestBody: DepositFundsRequestBody) -> Promise<DepositFundsResponseBody> {
        let (promise, resolver) = Promise<DepositFundsResponseBody>.pending()
        accountDepositFunds(depositFundsRequestBody: depositFundsRequestBody) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     depositFunds account
     - POST /account/deposit
     - put money in account
     - examples: [{contentType=application/json, example={
  "cashOnHand" : 0.8524634,
  "totalValue" : 0.36266223
}}]
     
     - parameter depositFundsRequestBody: (body)  

     - returns: RequestBuilder<DepositFundsResponseBody> 
     */
    open class func accountDepositFundsWithRequestBuilder(depositFundsRequestBody: DepositFundsRequestBody) -> RequestBuilder<DepositFundsResponseBody> {
        let path = "/account/deposit"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: depositFundsRequestBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<DepositFundsResponseBody>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     load account
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountLoad(completion: @escaping ((_ data: LoadResponseBody?,_ error: Error?) -> Void)) {
        accountLoadWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     load account
     
     - returns: Promise<LoadResponseBody>
     */
    open class func accountLoad() -> Promise<LoadResponseBody> {
        let (promise, resolver) = Promise<LoadResponseBody>.pending()
        accountLoad() { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     load account
     - GET /account/balance/load
     - read user app settings
     - examples: [{contentType=application/json, example={
  "cashOnHand" : 0.6617632,
  "totalValue" : 0.21615565
}}]

     - returns: RequestBuilder<LoadResponseBody> 
     */
    open class func accountLoadWithRequestBuilder() -> RequestBuilder<LoadResponseBody> {
        let path = "/account/balance/load"
        let URLString = NmgApiAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<LoadResponseBody>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     redeemShares account
     
     - parameter redeemSharesRequestBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountRedeemShares(redeemSharesRequestBody: RedeemSharesRequestBody, completion: @escaping ((_ data: Bool?,_ error: Error?) -> Void)) {
        accountRedeemSharesWithRequestBuilder(redeemSharesRequestBody: redeemSharesRequestBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     redeemShares account
     
     - parameter redeemSharesRequestBody: (body)  
     - returns: Promise<Bool>
     */
    open class func accountRedeemShares( redeemSharesRequestBody: RedeemSharesRequestBody) -> Promise<Bool> {
        let (promise, resolver) = Promise<Bool>.pending()
        accountRedeemShares(redeemSharesRequestBody: redeemSharesRequestBody) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     redeemShares account
     - POST /account/redeem
     - convert shares to currency
     - examples: [{contentType=application/json, example=true}]
     
     - parameter redeemSharesRequestBody: (body)  

     - returns: RequestBuilder<Bool> 
     */
    open class func accountRedeemSharesWithRequestBuilder(redeemSharesRequestBody: RedeemSharesRequestBody) -> RequestBuilder<Bool> {
        let path = "/account/redeem"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: redeemSharesRequestBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Bool>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     withdrawFunds account
     
     - parameter withdrawFundsRequestBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func accountWithdrawFunds(withdrawFundsRequestBody: WithdrawFundsRequestBody, completion: @escaping ((_ data: WithdrawFundsResponseBody?,_ error: Error?) -> Void)) {
        accountWithdrawFundsWithRequestBuilder(withdrawFundsRequestBody: withdrawFundsRequestBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     withdrawFunds account
     
     - parameter withdrawFundsRequestBody: (body)  
     - returns: Promise<WithdrawFundsResponseBody>
     */
    open class func accountWithdrawFunds( withdrawFundsRequestBody: WithdrawFundsRequestBody) -> Promise<WithdrawFundsResponseBody> {
        let (promise, resolver) = Promise<WithdrawFundsResponseBody>.pending()
        accountWithdrawFunds(withdrawFundsRequestBody: withdrawFundsRequestBody) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     withdrawFunds account
     - POST /account/withdraw
     - transfer funds out of the account
     - examples: [{contentType=application/json, example={
  "cashOnHand" : 0.36979464,
  "totalValue" : 0.72434324
}}]
     
     - parameter withdrawFundsRequestBody: (body)  

     - returns: RequestBuilder<WithdrawFundsResponseBody> 
     */
    open class func accountWithdrawFundsWithRequestBuilder(withdrawFundsRequestBody: WithdrawFundsRequestBody) -> RequestBuilder<WithdrawFundsResponseBody> {
        let path = "/account/withdraw"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: withdrawFundsRequestBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<WithdrawFundsResponseBody>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
