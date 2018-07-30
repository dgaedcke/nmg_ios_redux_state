//
// OrdersAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import PromiseKit



open class OrdersAPI {
    /**
     cancel orders
     
     - parameter cancelRequestBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func ordersCancel(cancelRequestBody: CancelRequestBody, completion: @escaping ((_ data: Bool?,_ error: Error?) -> Void)) {
        ordersCancelWithRequestBuilder(cancelRequestBody: cancelRequestBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     cancel orders
     
     - parameter cancelRequestBody: (body)  
     - returns: Promise<Bool>
     */
    open class func ordersCancel( cancelRequestBody: CancelRequestBody) -> Promise<Bool> {
        let (promise, resolver) = Promise<Bool>.pending()
        ordersCancel(cancelRequestBody: cancelRequestBody) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     cancel orders
     - POST /orders/cancel
     - cancels a pending Order
     - examples: [{contentType=application/json, example=true}]
     
     - parameter cancelRequestBody: (body)  

     - returns: RequestBuilder<Bool> 
     */
    open class func ordersCancelWithRequestBuilder(cancelRequestBody: CancelRequestBody) -> RequestBuilder<Bool> {
        let path = "/orders/cancel"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: cancelRequestBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Bool>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     list orders
     
     - parameter listRequestBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func ordersList(listRequestBody: ListRequestBody, completion: @escaping ((_ data: ListResponseBody?,_ error: Error?) -> Void)) {
        ordersListWithRequestBuilder(listRequestBody: listRequestBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     list orders
     
     - parameter listRequestBody: (body)  
     - returns: Promise<ListResponseBody>
     */
    open class func ordersList( listRequestBody: ListRequestBody) -> Promise<ListResponseBody> {
        let (promise, resolver) = Promise<ListResponseBody>.pending()
        ordersList(listRequestBody: listRequestBody) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     list orders
     - POST /orders/list
     - shows user Order history
     - examples: [{contentType=application/json, example={
  "orderResults" : [ {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  }, {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  }, {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  }, {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  } ]
}}]
     
     - parameter listRequestBody: (body)  

     - returns: RequestBuilder<ListResponseBody> 
     */
    open class func ordersListWithRequestBuilder(listRequestBody: ListRequestBody) -> RequestBuilder<ListResponseBody> {
        let path = "/orders/list"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: listRequestBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<ListResponseBody>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     refresh orders
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func ordersRefresh(completion: @escaping ((_ data: RefreshResponseBody?,_ error: Error?) -> Void)) {
        ordersRefreshWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     refresh orders
     
     - returns: Promise<RefreshResponseBody>
     */
    open class func ordersRefresh() -> Promise<RefreshResponseBody> {
        let (promise, resolver) = Promise<RefreshResponseBody>.pending()
        ordersRefresh() { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     refresh orders
     - POST /orders/refresh
     - load newest completed transactions
     - examples: [{contentType=application/json, example={
  "orderResults" : [ {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  }, {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  }, {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  }, {
    "clientID" : "Voluptatem ad earum quam porro vel quia.",
    "constraintMode" : "market",
    "cost" : 0.84335345,
    "execMode" : "sell",
    "shares" : 129307756,
    "status" : "Nulla eos.",
    "transID" : 6424881641900456408
  } ]
}}]

     - returns: RequestBuilder<RefreshResponseBody> 
     */
    open class func ordersRefreshWithRequestBuilder() -> RequestBuilder<RefreshResponseBody> {
        let path = "/orders/refresh"
        let URLString = NmgApiAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<RefreshResponseBody>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     submit orders
     
     - parameter submitRequestBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func ordersSubmit(submitRequestBody: SubmitRequestBody, completion: @escaping ((_ data: SubmitResponseBody?,_ error: Error?) -> Void)) {
        ordersSubmitWithRequestBuilder(submitRequestBody: submitRequestBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     submit orders
     
     - parameter submitRequestBody: (body)  
     - returns: Promise<SubmitResponseBody>
     */
    open class func ordersSubmit( submitRequestBody: SubmitRequestBody) -> Promise<SubmitResponseBody> {
        let (promise, resolver) = Promise<SubmitResponseBody>.pending()
        ordersSubmit(submitRequestBody: submitRequestBody) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     submit orders
     - POST /orders/submit
     - starts buy/sell of a team in an event
     - examples: [{contentType=application/json, example={
  "intID" : 7436444570611879960,
  "receivedTime" : "Iste velit itaque aut id.",
  "stringID" : "Dignissimos cum."
}}]
     
     - parameter submitRequestBody: (body)  

     - returns: RequestBuilder<SubmitResponseBody> 
     */
    open class func ordersSubmitWithRequestBuilder(submitRequestBody: SubmitRequestBody) -> RequestBuilder<SubmitResponseBody> {
        let path = "/orders/submit"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: submitRequestBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<SubmitResponseBody>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}