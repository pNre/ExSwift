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
        
        - parameter function: Function to call
    */
    func times <T> (_ function: @escaping (Void) -> T) {
        (0..<self).each { _ in _ = function(); return }
    }

    /**
        Calls function self times.
    
        - parameter function: Function to call
    */
    func times (_ function: @escaping (Void) -> Void) {
        (0..<self).each { _ in _ = function(); return }
    }

    /**
        Calls function self times passing a value from 0 to self on each call.
    
        - parameter function: Function to call
    */
    func times <T> (_ function: @escaping (Int) -> T) {
        (0..<self).each { index in _ = function(index); return }
    }

    /**
        Checks if a number is even.
    
        - returns: true if self is even
    */
    func isEven () -> Bool {
        return (self % 2) == 0
    }
    
    /**
        Checks if a number is odd.
    
        - returns: true if self is odd
    */
    func isOdd () -> Bool {
        return !isEven()
    }

    /**
        Iterates function, passing in integer values from self up to and including limit.
        
        - parameter limit: Last value to pass
        - parameter function: Function to invoke
    */
    func upTo (_ limit: Int, function: (Int) -> ()) {
        if limit < self {
            return
        }

        (self...limit).each(function)
    }
    
    /**
        Iterates function, passing in integer values from self down to and including limit.
        
        - parameter limit: Last value to pass
        - parameter function: Function to invoke
    */
    func downTo (_ limit: Int, function: (Int) -> ()) {
        if limit > self {
            return
        }

        Array(Array(limit...self).reversed()).each(function)
    }

    /**
        Clamps self to a specified range.
    
        - parameter range: Clamping range
        - returns: Clamped value
    */
    func clamp (_ range: Range<Int>) -> Int {
        return clamp(range.lowerBound, range.upperBound - 1)
    }
    
    /**
        Clamps self to a specified range.
        
        - parameter min: Lower bound
        - parameter max: Upper bound
        - returns: Clamped value
    */
    func clamp (_ min: Int, _ max: Int) -> Int {
        return Swift.max(min, Swift.min(max, self))
    }

    /**
        Checks if self is included a specified range.
        
        - parameter range: Range
        - parameter strict: If true, "<" is used for comparison
        - returns: true if in range
    */
    func isIn (_ range: Range<Int>, strict: Bool = false) -> Bool {
        if strict {
            return range.lowerBound < self && self < range.upperBound - 1
        }

        return range.lowerBound <= self && self <= range.upperBound - 1
    }
    
    /**
        Checks if self is included in a closed interval.
    
        - parameter interval: Interval to check
        - returns: true if in the interval
    */
    func isIn (_ interval: ClosedRange<Int>) -> Bool {
        return interval.contains(self)
    }
    
    /**
        Checks if self is included in an half open interval.
    
        - parameter interval: Interval to check
        - returns: true if in the interval
    */
    func isIn (_ interval: Range<Int>) -> Bool {
        return interval.contains(self)
    }
    
    /**
        Returns an [Int] containing the digits in self.
        
        :return: Array of digits
    */
    func digits () -> [Int] {
        var result = [Int]()
        
        for char in String(self).characters {
            let string = String(char)
            if let toInt = Int(string) {
                result.append(toInt)
            }
        }
    
        return result
    }
    
    /**
        Absolute value.
    
        - returns: abs(self)
    */
    func abs () -> Int {
        return Swift.abs(self)
    }
    
    /**
        Greatest common divisor of self and n.
    
        - parameter n:
        - returns: GCD
    */
    func gcd (_ n: Int) -> Int {
        return n == 0 ? self : n.gcd(self % n)
    }
    
    /**
        Least common multiple of self and n
    
        - parameter n:
        - returns: LCM
    */
    func lcm (_ n: Int) -> Int {
        return (self * n).abs() / gcd(n)
    }
    
    /**
        Computes the factorial of self
    
        - returns: Factorial
    */
    func factorial () -> Int {
        return self == 0 ? 1 : self * (self - 1).factorial()
    }
    
    /**
        Random integer between min and max (inclusive).
    
        - parameter min: Minimum value to return
        - parameter max: Maximum value to return
        - returns: Random integer
    */
    static func random(_ min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }

}

/**
    NSTimeInterval conversion extensions
*/
public extension Int {

    var years: TimeInterval {
        return 365 * self.days
    }

    var year: TimeInterval {
        return self.years
    }

    var days: TimeInterval {
        return 24 * self.hours
    }

    var day: TimeInterval {
        return self.days
    }

    var hours: TimeInterval {
        return 60 * self.minutes
    }

    var hour: TimeInterval {
        return self.hours
    }

    var minutes: TimeInterval {
        return 60 * self.seconds
    }

    var minute: TimeInterval {
        return self.minutes
    }

    var seconds: TimeInterval {
        return TimeInterval(self)
    }

    var second: TimeInterval {
        return self.seconds
    }

}
