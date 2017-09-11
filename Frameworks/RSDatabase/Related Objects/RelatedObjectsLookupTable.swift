//
//  RelatedObjectsLookupTable.swift
//  RSDatabase
//
//  Created by Brent Simmons on 9/10/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import Foundation

public struct RelatedObjectsLookupTable {
	
	private let dictionary: [String: [DatabaseObject]] // objectID: relatedObjects
	
	init(relatedObjects: relatedObjects, lookupTable: LookupTable) {
		
		var d = [String: [DatabaseObject]]()
		
		let relatedObjectsDictionary = relatedObjects.dictionary()
		let objectIDs = lookupTable.objectIDs()
		
		for objectID in lookupTable.objectIDs() {
			
			if let relatedObjectIDs = lookupTable[objectID] {
				let relatedObjects = relatedObjectIDs.flatMap{ relatedObjectsDictionary[$0] }
				if !relatedObjects.isEmpty {
					d[objectID] = relatedObjects
				}
			}
		}
		
		self.dictionary = d
	}
	
	public func objectIDs() -> Set<String> {
		
		return Set(dictionary.keys)
	}
	
	public subscript(_ objectID: String) -> [DatabaseObject]? {
		get {
			return dictionary[objectID]
		}
	}
}
