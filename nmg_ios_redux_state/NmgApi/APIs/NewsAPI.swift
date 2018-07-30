//
// NewsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import PromiseKit



open class NewsAPI {
    /**
     list News
     
     - parameter listRequestBody: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func newsList(listRequestBody: ListRequestBody, completion: @escaping ((_ data: NewsResultsResponseBodyCollection?,_ error: Error?) -> Void)) {
        newsListWithRequestBuilder(listRequestBody: listRequestBody).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     list News
     
     - parameter listRequestBody: (body)  
     - returns: Promise<NewsResultsResponseBodyCollection>
     */
    open class func newsList( listRequestBody: ListRequestBody) -> Promise<NewsResultsResponseBodyCollection> {
        let (promise, resolver) = Promise<NewsResultsResponseBodyCollection>.pending()
        newsList(listRequestBody: listRequestBody) { data, error in
            if let error = error {
                resolver.reject(error)
            } else {
                resolver.fulfill(data!)
            }
        }
        return promise
    }

    /**
     list News
     - POST /news/list
     - List news by event & optionally team
     - examples: [{contentType=application/json, example=""}]
     
     - parameter listRequestBody: (body)  

     - returns: RequestBuilder<NewsResultsResponseBodyCollection> 
     */
    open class func newsListWithRequestBuilder(listRequestBody: ListRequestBody) -> RequestBuilder<NewsResultsResponseBodyCollection> {
        let path = "/news/list"
        let URLString = NmgApiAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: listRequestBody)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<NewsResultsResponseBodyCollection>.Type = NmgApiAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
