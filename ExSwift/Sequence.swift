//
//  Sequence.swift
//  ExSwift
//
//  Created by Colin Eberhardt on 24/06/2014.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

internal extension SequenceOf {

    /**
        First element of the sequence.
    
        :returns: First element of the sequence if present
    */
    func first () -> T? {
        var generator =  self.generate()
        return generator.next()
    }
    
    /**
        Checks if call returns true for any element of self.
    
        :param: call Function to call for each element
        :returns: True if call returns true for any element of self
    */
    func any (call: (T) -> Bool) -> Bool {
        var generator =  self.generate()
        while let nextItem = generator.next() {
            if call(nextItem) {
                return true
            }
        }
        return false
    }

    /**
        Object at the specified index if exists.
    
        :param: index
        :returns: Object at index in sequence, nil if index is out of bounds
    */
    func get (index: Int) -> T? {
        var generator =  self.generate()
        for _ in 0..<(index - 1) {
            generator.next()
        }
        return generator.next()
    }
    
    /**
        Objects in the specified range.
    
        :param: range
        :returns: Subsequence in range
    */
    func get (range: Range<Int>) -> SequenceOf<T> {
        return self.skip(range.startIndex).take(range.endIndex - range.startIndex)
    }
    
    /**
        Index of the first occurrence of item, if found.
    
        :param: item The item to search for
        :returns: Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        var index = 0
        for current in self {
            if let equatable = current as? U {
                if equatable == item {
                    return index
                }
            }
            index++
        }
        return nil
    }
    
    /**
        Subsequence from n to the end of the sequence.
    
        :param: n Number of elements to skip
        :returns: Sequence from n to the end
    */
    func skip (n: Int) -> SequenceOf<T> {
        var generator =  self.generate()
        for _ in 0..<n {
            generator.next()
        }
        return SequenceOf(generator)
    }
    
    /**
        Filters the sequence only including items that match the test.
    
        :param: include Function invoked to test elements for inclusion in the sequence
        :returns: Filtered sequence
    */
    func filter(include: (T) -> Bool) -> SequenceOf<T> {
        return SequenceOf(lazy(self).filter(include))
    }
    
    /**
        Opposite of filter.
    
        :param: exclude Function invoked to test elements for exlcusion from the sequence
        :returns: Filtered sequence
    */
    func reject (exclude: (T -> Bool)) -> SequenceOf<T> {
        return self.filter {
            return !exclude($0)
        }
    }
    
    /**
        Skips the elements in the sequence up until the condition returns false.
    
        :param: condition A function which returns a boolean if an element satisfies a given condition or not
        :returns: Elements of the sequence starting with the element which does not meet the condition
    */
    func skipWhile(condition:(T) -> Bool) -> SequenceOf<T> {
        var generator =  self.generate()
        var checkingGenerator = self.generate()
        
        var keepSkipping = true
        
        while keepSkipping {
            var nextItem = checkingGenerator.next()
            keepSkipping = nextItem != nil ? condition(nextItem!) : false
            
            if keepSkipping {
                generator.next()
            }
        }
        return SequenceOf(generator)
    }
    
    /**
        Checks if self contains the item object.
    
        :param: item The item to search for
        :returns: true if self contains item
    */
    func contains<T:Equatable> (item: T) -> Bool {
        var generator =  self.generate()
        while let nextItem = generator.next() {
            if nextItem as T == item {
                return true
            }
        }
        return false
    }

    /**
        Returns the first n elements from self.
    
        :param: n Number of elements to take
        :returns: First n elements
    */
    func take (n: Int) -> SequenceOf<T> {
        return SequenceOf(TakeSequence(self, n))
    }
    
    /**
        Returns the elements of the sequence up until an element does not meet the condition.
    
        :param: condition A function which returns a boolean if an element satisfies a given condition or not.
        :returns: Elements of the sequence up until an element does not meet the condition
    */
    func takeWhile (condition:(T?) -> Bool) -> SequenceOf<T>  {
        return SequenceOf(TakeWhileSequence(self, condition))
    }
}

/**
    A sequence adapter that implements the 'take' functionality
*/
public struct TakeSequence<S: SequenceType>: SequenceType {
    private let sequence: S
    private let n: Int

    public init(_ sequence: S, _ n: Int) {
        self.sequence = sequence
        self.n = n
    }
 
    public func generate() -> GeneratorOf<S.Generator.Element> {
        var count = 0
        var generator = self.sequence.generate()
        return GeneratorOf<S.Generator.Element> {
            count++
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
public struct TakeWhileSequence<S: SequenceType>: SequenceType {
    private let sequence: S
    private let condition: (S.Generator.Element?) -> Bool
    
    public init(_ sequence:S, _ condition:(S.Generator.Element?) -> Bool) {
        self.sequence = sequence
        self.condition = condition
    }
    
    public func generate() -> GeneratorOf<S.Generator.Element> {
        var generator = self.sequence.generate()
        var endConditionMet = false
        return GeneratorOf<S.Generator.Element> {
            let next: S.Generator.Element? = generator.next()
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
