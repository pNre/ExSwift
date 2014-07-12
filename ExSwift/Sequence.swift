//
//  Sequence.swift
//  ExSwift
//
//  Created by Colin Eberhardt on 24/06/2014.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension SequenceOf {

    /**
    *  First element of the sequence
    *  @return First element of the sequence if present
    */
    func first () -> T? {
        var generator =  self.generate();
        return generator.next()
    }
    
    /**
    *  Checks if call returns true for any element of self
    *  @param call Function to call for each element
    *  @return True if call returns true for any element of self
    */
    func any (call: (T) -> Bool) -> Bool {
        var generator =  self.generate();
        while let nextItem = generator.next() {
            if call(nextItem) {
                return true
            }
        }
        return false
    }
    
    /**
    *  Object at the specified index if exists
    *  @param index
    *  @return Object at index in sequence, nil if index is out of bounds
    */
    func get (index: Int) -> T? {
        var generator =  self.generate();
        for _ in 0..<(index - 1) {
            generator.next()
        }
        return generator.next()
    }
    
    /**
    *  Objects in the specified range
    *  @param range
    *  @return Subsequence in range
    */
    func get (range: Range<Int>) -> SequenceOf<T> {
        return self.skip(range.startIndex)
            .take(range.endIndex - range.startIndex)
    }
    
    /**
    *  Index of the first occurrence of item, if found
    *  @param item The item to search for
    *  @return Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        var index = 0;
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
    *  Subsequence from n to the end of the sequence
    *  @return Sequence from n to the end
    */
    func skip (n:Int) -> SequenceOf<T> {
        var generator =  self.generate();
        for _ in 0..<n {
            generator.next()
        }
        return SequenceOf(generator)
    }
    
    /**
    *  Filters the sequence only including items that match the test
    *  @param include Function invoked to test elements for inclusion in the sequence
    *  @return Filtered sequence
    */
    func filter(include: (T) -> Bool) -> SequenceOf<T> {
        return SequenceOf(Swift.filter(self, include))
    }
    
    /**
    *  Opposite of filter
    *  @param exclude Function invoked to test elements for exlcusion from the sequence
    *  @return Filtered sequence
    */
    func reject (exclude: (T -> Bool)) -> SequenceOf<T> {
        return self.filter {
            return !exclude($0)
        }
    }
    
    /**
    *  Skips the elements in the sequence up until the condition returns false
    *  @param condition A function which returns a boolean if an element satisfies a given condition or not
    *  @return Elements of the sequence starting with the element which does not meet the condition
    */
    func skipWhile(condition:(T) -> Bool) -> SequenceOf<T> {
        var generator =  self.generate();
        var keepSkipping = true
        while keepSkipping {
            if let nextItem = generator.next() {
                keepSkipping = condition(nextItem)
            } else {
                keepSkipping = false
            }
        }
        return SequenceOf(generator)
    }
    
    /**
    *  Checks if self contains the item object
    *  @param item The item to search for
    *  @return true if self contains item
    */
    func contains<T:Equatable> (item: T) -> Bool {
        var generator =  self.generate();
        while let nextItem = generator.next() {
            if nextItem as T == item {
                return true;
            }
        }
        return false
    }

    /**
    *  Returns the first n elements from self
    *  @return First n elements
    */
    func take (n:Int) -> SequenceOf<T> {
        return SequenceOf(TakeSequence(self, n))
    }
    
    /**
    *  Returns the elements of the sequence up until an element does not meet the condition
    *  @param condition A function which returns a boolean if an element satisfies a given condition or not.
    *  @return Elements of the sequence up until an element does not meet the condition
    */
    func takeWhile (condition:(T?) -> Bool) -> SequenceOf<T>  {
        return SequenceOf(TakeWhileSequence(self, condition))
    }
}

// a sequence adapter that implements the 'take' functionality
struct TakeSequence<S: Sequence>: Sequence {
    let sequence: S
    let n: Int

    init(_ sequence: S, _ n: Int) {
        self.sequence = sequence
        self.n = n
    }
 
    func generate() -> GeneratorOf<S.GeneratorType.Element> {
        var count = 0
        var generator = self.sequence.generate()
        return GeneratorOf<S.GeneratorType.Element> {
            count++
            if count > self.n {
                return nil
            } else {
                return generator.next()
            }
        }
    }
}

// a sequence adapter that implements the 'takeWhile' functionality
struct TakeWhileSequence<S: Sequence>: Sequence {
    let sequence: S
    let condition: (S.GeneratorType.Element?) -> Bool
    
    init(_ sequence:S, _ condition:(S.GeneratorType.Element?) -> Bool) {
        self.sequence = sequence
        self.condition = condition
    }
    
    func generate() -> GeneratorOf<S.GeneratorType.Element> {
        var generator = self.sequence.generate()
        var endConditionMet = false
        return GeneratorOf<S.GeneratorType.Element> {
            let next: S.GeneratorType.Element? = generator.next()
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