//
//  Int.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension Int {
    
    /**
    *  Calls a function self times
    *  @param call Function to call
    */
    func times (call: () -> Any) {
        for _ in 0..self {
            call()
        }
    }
    
    /**
    *  Calls a function self times (with no return value)
    *  @param call Function to call
    */
    func times (call: () -> ()) {
        for _ in 0..self {
            call()
        }
    }
    
    /**
    *  Sleeps for self seconds
    */
    func sleep () {
        NSThread.sleepForTimeInterval(Double(self))
    }
    
    /**
    *  Checks if a number is even
    *  @return True if self is even
    */
    func isEven () -> Bool {
        return (self % 2) == 0
    }
    
    /**
    *  Checks if a number is odd
    *  @return True if self is odd
    */
    func isOdd () -> Bool {
        return !self.isEven()
    }
    
    /**
    *  Returns a random integer between min and max (inclusive)
    *  @return Random integer
    */
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}
