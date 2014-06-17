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
    *  Calls a function foreach element in the range
    *  @param call Function to call
    */
    func times (call: () -> ()) {
        each { (current: T) -> () in
            call()
        }
    }

    /**
    *  Calls a function foreach element in the range
    *  @param call Function to call
    */
    func times (call: (T) -> ()) {
        each (call)
    }

    /**
    *  Calls a function foreach element in the range
    *  @param call Function to call
    */
    func each (call: (T) -> ()) {
        for i in self {
            call(i)
        }
    }

    /**
     * Returns `Range` with random bounds between `min` and `max` (inclusive).
    */
    static func random (from: Int, to: Int) -> Range<Int> {
        
        let lowerBound = Int.random(min: from, max: to)
        let upperBound = Int.random(min: lowerBound, max: to)
        
        return lowerBound...upperBound

    }

}

/**
*  Ranges comparison
*/
@infix func == <U: ForwardIndex> (first: Range<U>, second: Range<U>) -> Bool {
    return first.startIndex == second.startIndex &&
           first.endIndex == second.endIndex
}
