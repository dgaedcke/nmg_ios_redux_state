//
//  SubscribableSuperclass.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/14/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
/*
	purpose of RDXSubscribableSuper class is to make any of my more complex
	state-singletons to be subscribable
	by VC's and views

*/

//import Foundation
//
//typealias RDXFilterTuple = (String, String)
//
//
//fileprivate struct RDXFilter {
//	let className:String
//	let instanceKey:String
//	
//	var fullKey:String {
//		return RDXFilter.getKey(c:className, i:instanceKey)
//	}
//	
//	func doesMatch(t:RDXFilterTuple) -> Bool {
//		return t.0 == className && t.1 == instanceKey
//	}
//	
//	static func getKey(c:String, i:String) -> String {
//		return c + "-" + i
//	}
//}
//
//
//fileprivate struct RDXSubscriptionConfig {
//	let objID:ObjectIdentifier
//	private let subscriber:ScopedSubscriberProto
//	private let filters:[RDXFilter]
//		
//	fileprivate init(subscriber:ScopedSubscriberProto, recFilters:[RDXFilterTuple]) {
//		
//		var f = [RDXFilter]()
//		for t in recFilters {
//			f.append(RDXFilter(className: t.0, instanceKey: t.1))
//		}
//		self.filters = f
//		self.subscriber = subscriber
//		self.objID = ObjectIdentifier(subscriber)
//	}
//	
//	fileprivate func subscriberIfIsMatch(for recFilters:[RDXFilterTuple]) -> ScopedSubscriberProto? {
//		guard recFilters.count > 0 else { return nil }
//		
//		for recFilter in recFilters {
//			for stored in self.filters {
//				if stored.doesMatch(t: recFilter) {
//					return self.subscriber
//				}
//			}
//		}
//		return nil
//	}
//}
//
//
//class RDXSubscribableSuper {
//	// Super class for all view-state-api singletons
//	//
//	private var subscriptions = [ObjectIdentifier:RDXSubscriptionConfig]()
//	
//	func subscribe(sub:ScopedSubscriberProto, filters: [RDXFilterTuple]) {
//		let objID = ObjectIdentifier(sub)
//		subscriptions[objID] = RDXSubscriptionConfig(subscriber: sub, recFilters: filters)
//	}
//	
//	func refreshSubscription(sub:ScopedSubscriberProto, filters: [RDXFilterTuple]) {
//		self.subscribe(sub: sub, filters: filters)
//		
//	}
//	
//	func unsubscribe(sub:ScopedSubscriberProto) {
//		let objID = ObjectIdentifier(sub)
//		subscriptions[objID] = nil
//	}
//	
//	func publishChanges(rec:StateValueProto) {
//		// called when subclass gets notification from store that data has changed
//		let changedClassName = rec.typeAsString()
//		let changedRecID = rec.id
//		let key = RDXFilter.getKey(c:changedClassName, i:changedRecID)
//		for (oid, sc) in subscriptions {
//			if let sub = sc.subscriberIfIsMatch( for: [(changedClassName, changedRecID)] ) {
//				sub.scopedStateChangeCallback(rec: rec)
//			}
//		}
//		
//	}
//}
