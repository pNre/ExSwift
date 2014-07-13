//
//  Range.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension Range {
    
    /**
    *  For each element in the range invokes function
    *  @param call Function to call
    */
    func times (function: () -> ()) {
        each { (current: T) -> () in
            function()
        }
    }

    /**
    *  Equivalent to: each
    *  @param function Function to invoke
    */
    func times (function: (T) -> ()) {
        each (function)
    }

    /**
    *  For each element in the range invokes function passing the element as argument
    *  @param function Function to invoke
    */
    func each (function: (T) -> ()) {
        for i in self {
            function(i)
        }
    }

    /**
    *  Int Range with random bounds between from and to (inclusive).
    *  @param from Lower bound
    *  @param to Upper bound
    *  @return Random range
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
@infix func == <U: ForwardIndex> (first: Range<U>, second: Range<U>) -> Bool {
    return first.startIndex == second.startIndex &&
           first.endIndex == second.endIndex
}

/**
*  DP2 style open range operator
*/
@infix func .. <U> (first: U, second: U) -> Range<U> {
    return first..<second
}

