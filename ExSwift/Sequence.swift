//
//  Sequence.swift
//  ExSwift
//
//  Created by Colin Eberhardt on 24/06/2014.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

internal extension AnySequence {

    /**
        First element of the sequence.
    
        - returns: First element of the sequence if present
    */
    var first: Element? {
        let generator =  self.makeIterator()
        return generator.next()
    }

    /**
        Checks if call returns true for any element of self.
    
        - parameter call: Function to call for each element
        - returns: True if call returns true for any element of self
    */
    func any (_ call: (Element) -> Bool) -> Bool {
        let generator =  self.makeIterator()
        while let nextItem = generator.next() {
            if call(nextItem) {
                return true
            }
        }
        return false
    }

    /**
        Object at the specified index if exists.
    
        - parameter index:
        - returns: Object at index in sequence, nil if index is out of bounds
    */
    func get (_ index: Int) -> Element? {
        let generator =  self.makeIterator()
        for _ in 0..<(index - 1) {
            generator.next()
        }
        return generator.next()
    }
    
    /**
        Objects in the specified range.
    
        - parameter range:
        - returns: Subsequence in range
    */
    func get (_ range: Range<Int>) -> AnySequence<Element> {
        return self.skip(range.lowerBound).take(range.upperBound - range.lowerBound)
    }
    
    /**
        Index of the first occurrence of item, if found.
    
        - parameter item: The item to search for
        - returns: Index of the matched item or nil
    */
    func indexOf <U: Equatable> (_ item: U) -> Int? {
        var index = 0
        for current in self {
            if let equatable = current as? U {
                if equatable == item {
                    return index
                }
            }
            index += 1
        }
        return nil
    }
    
    /**
        Subsequence from n to the end of the sequence.
    
        - parameter n: Number of elements to skip
        - returns: Sequence from n to the end
    */
    func skip (_ n: Int) -> AnySequence<Element> {
        let generator =  self.makeIterator()
        for _ in 0..<n {
            generator.next()
        }
        return AnySequence(generator)
    }
    
    /**
        Filters the sequence only including items that match the test.
    
        - parameter include: Function invoked to test elements for inclusion in the sequence
        - returns: Filtered sequence
    */
    func filter(_ include: (Element) -> Bool) -> AnySequence<Element> {
        return AnySequence(self.filter(include))
    }
    
    /**
        Opposite of filter.
    
        - parameter exclude: Function invoked to test elements for exlcusion from the sequence
        - returns: Filtered sequence
    */
    func reject (_ exclude: ((Element) -> Bool)) -> AnySequence<Element> {
        return self.filter {
            return !exclude($0)
        }
    }
    
    /**
        Skips the elements in the sequence up until the condition returns false.
    
        - parameter condition: A function which returns a boolean if an element satisfies a given condition or not
        - returns: Elements of the sequence starting with the element which does not meet the condition
    */
    func skipWhile(_ condition:(Element) -> Bool) -> AnySequence<Element> {
        let generator =  self.makeIterator()
        let checkingGenerator = self.makeIterator()
        
        var keepSkipping = true
        
        while keepSkipping {
            let nextItem = checkingGenerator.next()
            keepSkipping = nextItem != nil ? condition(nextItem!) : false
            
            if keepSkipping {
                generator.next()
            }
        }
        return AnySequence(generator)
    }
    
    /**
        Checks if self contains the item object.
    
        - parameter item: The item to search for
        - returns: true if self contains item
    */
    func contains<Element:Equatable> (_ item: Element) -> Bool {
        let generator =  self.makeIterator()
        while let nextItem = generator.next() {
            if nextItem as! Element == item {
                return true
            }
        }
        return false
    }

    /**
        Returns the first n elements from self.
    
        - parameter n: Number of elements to take
        - returns: First n elements
    */
    func take (_ n: Int) -> AnySequence<Element> {
        return AnySequence(TakeSequence(self, n))
    }
    
    /**
        Returns the elements of the sequence up until an element does not meet the condition.
    
        - parameter condition: A function which returns a boolean if an element satisfies a given condition or not.
        - returns: Elements of the sequence up until an element does not meet the condition
    */
    func takeWhile (_ condition:@escaping (Element?) -> Bool) -> AnySequence<Element>  {
        return AnySequence(TakeWhileSequence(self, condition))
    }

    /**
        Returns each element of the sequence in an array
	
        - returns: Each element of the sequence in an array
    */
    func toArray () -> [Element] {
        var result: [Element] = []
        for item in self {
            result.append(item)
        }
        return result
    }
}

/**
    A sequence adapter that implements the 'take' functionality
*/
public struct TakeSequence<S: Sequence>: Sequence {
    fileprivate let sequence: S
    fileprivate let n: Int

    public init(_ sequence: S, _ n: Int) {
        self.sequence = sequence
        self.n = n
    }
 
    public func makeIterator() -> AnyIterator<S.Iterator.Element> {
        var count = 0
        var generator = self.sequence.makeIterator()
        return AnyIterator {
            count += 1
            if count > self.n {
                return nil
            } else {
                return generator.next()
            }
        }
    }
}

/**
    a sequence adapter that implements the 'takeWhile' functionality
*/
public struct TakeWhileSequence<S: Sequence>: Sequence {
    fileprivate let sequence: S
    fileprivate let condition: (S.Iterator.Element?) -> Bool
    
    public init(_ sequence:S, _ condition:@escaping (S.Iterator.Element?) -> Bool) {
        self.sequence = sequence
        self.condition = condition
    }
    
    public func makeIterator() -> AnyIterator<S.Iterator.Element> {
        var generator = self.sequence.makeIterator()
        var endConditionMet = false
        return AnyIterator {
            let next: S.Iterator.Element? = generator.next()
            if !endConditionMet {
                endConditionMet = !self.condition(next)
            }
            if endConditionMet {
                return nil
            } else {
                return next
            }
        }
    }
}
