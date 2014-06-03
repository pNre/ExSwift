//
//  Int.swift
//  Extensions
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
}
