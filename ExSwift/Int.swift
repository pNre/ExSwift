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
    *  Calls function self times
    *  @param function Function to call
    */
    func times <T> (function: () -> T) {
        self.times({
            (index: Int) -> T in
            return function()
        })
    }

    /**
    *  Calls function self times
    *  @param function Function to call
    */
    func times (function: () -> ()) {
        self.times({
            (index: Int) -> () in
            function()
        })
    }

    /**
    *  Calls function self times passing a value from 0 to self on each call
    *  @param function Function to call
    */
    func times <T> (function: (Int) -> T) {
        (0..<self).each { index in function(index); return }
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
    *  Iterates function, passing in integer values from self up to and including limit.
    *  @param limit Last value to pass
    *  @param function Function to invoke
    */
    func upTo (limit: Int, function: (Int) -> ()) {
        if limit < self {
            return
        }

        (self...limit).each(function)
    }
    
    /**
    *  Iterates function, passing in integer values from self down to and including limit.
    *  @param limit Last value to pass
    *  @param function Function to invoke
    */
    func downTo (limit: Int, function: (Int) -> ()) {
        if limit > self {
            return
        }

        Array(limit...self).reverse().each(function)
    }

    /**
    *  Clamps self to range
    *  @param range Clamping range
    *  @return Clamped value
    */
    func clamp (range: Range<Int>) -> Int {
        if self > range.endIndex - 1 {
            return range.endIndex - 1
        } else if self < range.startIndex {
            return range.startIndex
        }
        
        return self
    }
    
    /**
    *  Clamps self to a range min...max
    *  @param min Lower bound
    *  @param max Upper bound
    *  @return Clamped value
    */
    func clamp (min: Int, max: Int) -> Int {
        return clamp(min...max)
    }

    /**
    *  Check if self is included in range
    *  @param range Range
    *  @param string If true, "<" is used for comparison
    *  @return true if in range
    */
    func isIn (range: Range<Int>, strict: Bool = false) -> Bool {
        if strict {
            return range.startIndex < self && self < range.endIndex - 1
        }

        return range.startIndex <= self && self <= range.endIndex - 1
    }

    /**
    *  Returns a Int[] containing the digits in self
    *  @return Array of digits
    */
    func digits () -> Array<Int> {
        var result = Array<Int>()
        
        for char in String(self) {
            let string = String(char)
            if let toInt = string.toInt() {
                result.append(toInt)
            }
        }
    
        return result
    }
    
    /**
    *  Absolute value
    *  @return abs(self)
    */
    func abs () -> Int {
        return Swift.abs(self)
    }
    
    /**
    *  Greatest common divisor of self and n
    *  @param n
    *  @return GCD
    */
    func gcd (n: Int) -> Int {
        return n == 0 ? self : n.gcd(self % n)
    }
    
    /**
    *  Least common multiple of self and n
    *  @param n
    *  @return LCM
    */
    func lcm (n: Int) -> Int {
        return (self * n).abs() / gcd(n)
    }
    
    /**
    *  Random integer between min and max (inclusive).
    *  @return Random integer
    */
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}

