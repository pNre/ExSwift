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
        self.each { (current: T) -> () in
            call()
        }
    }

    /**
    *  Calls a function foreach element in the range
    *  @param call Function to call
    */
    func times (call: (T) -> ()) {
        self.each (call)
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

}

/**
*  Ranges comparison
*/
@infix func == <U: ForwardIndex> (first: Range<U>, second: Range<U>) -> Bool {
    return first.startIndex == second.startIndex &&
           first.endIndex == second.endIndex
}
