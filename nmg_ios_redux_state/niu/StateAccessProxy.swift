//
//  StateAccessProxy.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/8/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

//import Foundation
//
//protocol StateAccessProxyProtocol {
//	/*  any obj that knows how to lookup records by key
//		as a convenience to other areas of the state system
//	*/
//	func listByType<R:StateValueProto>() -> [R]
//	func getLatest<R:StateValueProto>(id recID:String) -> R?
//}
//
//class StateAccessProxy {
//	/*
//
//	*/
//	static let shared = StateAccessProxy()
//	private let stateStore = store	// read only copy of global store
//}
//
//extension StateAccessProxy: StateAccessProxyProtocol {
//	
//	func listByType<R:StateValueProto>() -> [R] {
//		return []
//	}
//	func getLatest<R:StateValueProto>(id recID:String) -> R? {
//		return nil
//	}
//}
