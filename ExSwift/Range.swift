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
        
        :param: function Function to call
    */
    func times (function: () -> ()) {
        each { (current: T) -> () in
            function()
        }
    }

    /**
        For each element in the range invokes function passing the element as argument.
    
        :param: function Function to invoke
    */
    func times (function: (T) -> ()) {
        each (function)
    }

    /**
        For each element in the range invokes function passing the element as argument.
    
        :param: function Function to invoke
    */
    func each (function: (T) -> ()) {
        for i in self {
            function(i)
        }
    }

    /**
        Range of Int with random bounds between from and to (inclusive).
        
        :param: from Lower bound
        :param: to Upper bound
        :returns: Random range
    */
    static func random (from: Int, to: Int) -> Range<Int> {
        
        let lowerBound = Int.random(min: from, max: to)
        let upperBound = Int.random(min: lowerBound, max: to)
        
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

/**
*  DP2 style open range operator
*/
public func .. <U : Comparable> (first: U, second: U) -> HalfOpenInterval<U> {
    return first..<second
}

