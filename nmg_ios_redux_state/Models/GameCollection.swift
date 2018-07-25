//
//  GameCollection.swift
//  nmg_ios
//
//  Created by Dewey Gaedcke on 5/9/17.
//  Copyright © 2017 New Millennial Games, LLC. All rights reserved.
//

// abstraction not currently in use
// copy to nmg_ios


struct GameCollection<Element: Hashable> {
	// custom collection of existing "game" records for the user
	
	fileprivate var contents: [Element: Int] = [:]
	
	
	var uniqueCount: Int {
		return contents.count
	}
	
	
	var totalCount: Int {
		return contents.values.reduce(0) { $0 + $1 }
	}
	
	
	init() { }
	
	
	init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
		for element in sequence {
			add(element)
		}
	}
	
	
	init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Element, value: Int) {
		for (element, count) in sequence {
			add(element, occurrences: count)
		}
	}
	
	
	mutating func add(_ member: Element, occurrences: Int = 1) {
		
		precondition(occurrences > 0, "Can only add a positive number of occurrences")
		
		
		if let currentCount = contents[member] {
			contents[member] = currentCount + occurrences
		} else {
			contents[member] = occurrences
		}
	}
	
	mutating func remove(_ member: Element, occurrences: Int = 1) {
		
		guard let currentCount = contents[member], currentCount >= occurrences else {
			preconditionFailure("Removed non-existent elements")
		}
		
		
		precondition(occurrences > 0, "Can only remove a positive number of occurrences")
		
		
		if currentCount > occurrences {
			contents[member] = currentCount - occurrences
		} else {
			contents.removeValue(forKey: member)
		}
	}
}

extension GameCollection: CustomStringConvertible {
	var description: String {
		return String(describing: contents)
	}
}

extension GameCollection: ExpressibleByArrayLiteral {
	init(arrayLiteral elements: Element...) {
		self.init(elements)
	}
}

extension GameCollection: ExpressibleByDictionaryLiteral {
	init(dictionaryLiteral elements: (Element, Int)...) {
		
		self.init(elements.map { (key: $0.0, value: $0.1) })
	}
}

extension GameCollection: Sequence {
	
	typealias Iterator = AnyIterator<(element: Element, count: Int)>
	
	func makeIterator() -> Iterator {
		
		var iterator = contents.makeIterator()
		
		return AnyIterator {
			return iterator.next()
		}
	}
}

extension GameCollection: Collection {
	
	typealias Index = GameCollectionIndex<Element>
	
	var startIndex: Index {
		
		return GameCollectionIndex(contents.startIndex)
	}
	
	var endIndex: Index {
		
		return GameCollectionIndex(contents.endIndex)
	}
	
	subscript (position: Index) -> Iterator.Element {
		precondition((startIndex ..< endIndex).contains(position), "out of bounds")
		
		let dictionaryElement = contents[position.index]
		return (element: dictionaryElement.key, count: dictionaryElement.value)
	}
	
	func index(after i: Index) -> Index {
		
		return Index(contents.index(after: i.index))
	}
}


struct GameCollectionIndex<Element: Hashable> {
	
	fileprivate let index: DictionaryIndex<Element, Int>
	
	
	fileprivate init(_ dictionaryIndex: DictionaryIndex<Element, Int>) {
		self.index = dictionaryIndex
	}
}

extension GameCollectionIndex: Comparable {
	static func == (lhs: GameCollectionIndex, rhs: GameCollectionIndex) -> Bool {
		return lhs.index == rhs.index
	}
	
	static func < (lhs: GameCollectionIndex, rhs: GameCollectionIndex) -> Bool {
		return lhs.index < rhs.index
	}
}

