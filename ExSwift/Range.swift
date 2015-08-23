//
//  Range.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

internal extension Range {
    
    /**
        For each element in the range invokes function.
        
        - parameter function: Function to call
    */
    func times (function: () -> ()) {
        each { (current: Element) -> () in
            function()
        }
    }

    /**
        For each element in the range invokes function passing the element as argument.
    
        - parameter function: Function to invoke
    */
    func times (function: (Element) -> ()) {
        each (function)
    }

    /**
        For each element in the range invokes function passing the element as argument.
    
        - parameter function: Function to invoke
    */
    func each (function: (Element) -> ()) {
        for i in self {
            function(i)
        }
    }

	/**
		Returns each element of the range in an array
	
		- returns: Each element of the range in an array
	*/
    func toArray () -> [Element] {
        var result: [Element] = []
        for i in self {
            result.append(i)
        }
        return result
    }

    /**
        Range of Int with random bounds between from and to (inclusive).
    
        - parameter from: Lower bound
        - parameter to: Upper bound
        - returns: Random range
    */
    static func random (from: Int, to: Int) -> Range<Int> {
        let lowerBound = Int.random(from, max: to)
        let upperBound = Int.random(lowerBound, max: to)
        
        return lowerBound...upperBound
    }

}

/**
*  Operator == to compare 2 ranges first, second by start & end indexes. If first.startIndex is equal to
*  second.startIndex and first.endIndex is equal to second.endIndex the ranges are considered equal.
*/
public func == <U: ForwardIndexType> (first: Range<U>, second: Range<U>) -> Bool {
    return first.startIndex == second.startIndex &&
           first.endIndex == second.endIndex
}
