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
    func times <T> (call: () -> T) {
        self.times({
            (index: Int) -> T in
            return call()
        })
    }
    
    /**
    *  Calls a function self times (with no return value)
    *  @param call Function to call
    */
    func times (call: () -> ()) {
        self.times({
            (index: Int) -> () in
            call()
        })
    }

    /**
    *  Calls a function self times
    *  @param call Function to call
    */
    func times <T> (call: (Int) -> T) {
        for i in 0..self {
            call(i)
        }
    }
    
    /**
    *  Creates a function that executes call only after being called n times
    *  @param call Function to call after self times
    *  @return Newly constructed function
    */
    func after <T> (call: () -> T) -> (() -> T?) {
        var times = self
        return {
            if times-- <= 0 {
                return call()
            }
            
            return nil
        }
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
     *  Iterates call, passing in integer values from self up to and including limit.
     */
    func upTo (limit: Int, call: (Int) -> ()) {
        if limit < self {
            return
        }

        (self...limit).each(call)
    }
    
    /**
    *  Iterates call, passing in integer values from self down to and including limit.
    */
    func downTo (limit: Int, call: (Int) -> ()) {
        if limit > self {
            return
        }

        Array(limit...self).reverse().each(call)
    }
    
    /**
    *  Returns a random integer between min and max (inclusive)
    *  @return Random integer
    */
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}
