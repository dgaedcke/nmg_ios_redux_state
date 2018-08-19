//
//  MiscDontCopy.swift
//  nmg_ios_redux_state
//
//  Created by Dewey Gaedcke on 8/18/18.
//  Copyright © 2018 Dewey Gaedcke. All rights reserved.
//

import Foundation


protocol EntityRecProto{
	// empty for reuse
}

protocol BasicRWProto {
	
	var id:String {get}
	var fullNodePath:String {get}
	
	static var dbPathPrefix:String {get}
	static var tableName:String {get}
	static var keyGenMethod:KeyGenType {get}
	//	static var canUpdate:Bool {get}
	//	static var canDelete:Bool {get}
}

protocol DbModelProto: BasicRWProto, CustomStringConvertible, Hashable {		// : JSONAble
	// super class for all DB tables
	
	var id:String {get}
	var name:String {get}
	var displayName:String {get}
}

extension DbModelProto {
	// default implementation for DB Tables
	
	static var dbPathPrefix:String {
		return EntityType.table.dbPathPrefix
	}
	
	static var tableRoot:String {
		// all Model recs live under this path
		return "\(Self.dbPathPrefix)\(Self.tableName)"
	}
	
	var fullNodePath:String {
		// self instance rec lives under this path
		return "\(Self.tableRoot)/\(self.id)"
	}
}


extension DbModelProto {
	// Protocol conformance:   CustomStringConvertible, Hashable
	
	var displayName:String {
		return name
	}
	
	var description:String {
		return "\(Self.tableName) \(id)"
	}
	
	var hashValue:Int {
		return 1
	}
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.id == rhs.id
	}
}


enum KeyGenType {
	// describes how keys created for each model obj
	case server	// time-series key generated on server
	case name	// use entity name as key/id
	case staticFunction  // call local func to get string key
	case uuid	// just give me a new uuid
}

enum EntityType {
	case table
	case sharedTable
	case stat
	case log
	case thread
	case unknown
	
	var dbPathPrefix:String {
		switch self {
		case .table:       return "/table/"
		case .sharedTable: return "/clientGlobal/"
		case .stat:        return "/stats/"
		case .log:         return "/log/"
		case .thread:      return "/communicationGroup/"
		default:           return "unknown"
		}
	}
}
