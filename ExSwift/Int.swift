//
//  Int.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Int {
    
    /**
        Calls function self times.
        
        :param: function Function to call
    */
    func times <T> (function: Void -> T) {
        (0..<self).each { _ in function(); return }
    }

    /**
        Calls function self times.
    
        :param: function Function to call
    */
    func times (function: Void -> Void) {
        (0..<self).each { _ in function(); return }
    }

    /**
        Calls function self times passing a value from 0 to self on each call.
    
        :param: function Function to call
    */
    func times <T> (function: (Int) -> T) {
        (0..<self).each { index in function(index); return }
    }

    /**
        Checks if a number is even.
    
        :returns: true if self is even
    */
    func isEven () -> Bool {
        return (self % 2) == 0
    }
    
    /**
        Checks if a number is odd.
    
        :returns: true if self is odd
    */
    func isOdd () -> Bool {
        return !isEven()
    }

    /**
        Iterates function, passing in integer values from self up to and including limit.
        
        :param: limit Last value to pass
        :param: function Function to invoke
    */
    func upTo (limit: Int, function: (Int) -> ()) {
        if limit < self {
            return
        }

        (self...limit).each(function)
    }
    
    /**
        Iterates function, passing in integer values from self down to and including limit.
        
        :param: limit Last value to pass
        :param: function Function to invoke
    */
    func downTo (limit: Int, function: (Int) -> ()) {
        if limit > self {
            return
        }

        Array(limit...self).reverse().each(function)
    }

    /**
        Clamps self to a specified range.
    
        :param: range Clamping range
        :returns: Clamped value
    */
    func clamp (range: Range<Int>) -> Int {
        return clamp(range.startIndex, range.endIndex - 1)
    }
    
    /**
        Clamps self to a specified range.
        
        :param: min Lower bound
        :param: max Upper bound
        :returns: Clamped value
    */
    func clamp (min: Int, _ max: Int) -> Int {
        return Swift.max(min, Swift.min(max, self))
    }

    /**
        Checks if self is included a specified range.
        
        :param: range Range
        :param: string If true, "<" is used for comparison
        :returns: true if in range
    */
    func isIn (range: Range<Int>, strict: Bool = false) -> Bool {
        if strict {
            return range.startIndex < self && self < range.endIndex - 1
        }

        return range.startIndex <= self && self <= range.endIndex - 1
    }
    
    /**
        Checks if self is included in a closed interval.
    
        :param: interval Interval to check
        :returns: true if in the interval
    */
    func isIn (interval: ClosedInterval<Int>) -> Bool {
        return interval.contains(self)
    }
    
    /**
        Checks if self is included in an half open interval.
    
        :param: interval Interval to check
        :returns: true if in the interval
    */
    func isIn (interval: HalfOpenInterval<Int>) -> Bool {
        return interval.contains(self)
    }
    
    /**
        Returns an [Int] containing the digits in self.
        
        :return: Array of digits
    */
    func digits () -> [Int] {
        var result = [Int]()
        
        for char in String(self) {
            let string = String(char)
            if let toInt = string.toInt() {
                result.append(toInt)
            }
        }
    
        return result
    }
    
    /**
        Absolute value.
    
        :returns: abs(self)
    */
    func abs () -> Int {
        return Swift.abs(self)
    }
    
    /**
        Greatest common divisor of self and n.
    
        :param: n
        :returns: GCD
    */
    func gcd (n: Int) -> Int {
        return n == 0 ? self : n.gcd(self % n)
    }
    
    /**
        Least common multiple of self and n
    
        :param: n
        :@returns: LCM
    */
    func lcm (n: Int) -> Int {
        return (self * n).abs() / gcd(n)
    }
    
    /**
        Random integer between min and max (inclusive).
    
        :param: min Minimum value to return
        :param: max Maximum value to return
        :returns: Random integer
    */
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}

