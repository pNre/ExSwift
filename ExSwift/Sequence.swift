//
//  Sequence.swift
//  ExSwift
//
//  Created by Colin Eberhardt on 24/06/2014.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation


extension SequenceOf {

    func first () -> T? {
        var generator =  self.generate();
        return generator.next()
    }
    
    func any (call: (T) -> Bool) -> Bool {
        var generator =  self.generate();
        while let nextItem = generator.next() {
            if call(nextItem) {
                return true
            }
        }
        return false
    }
    
    func get (index: Int) -> T? {
        var generator =  self.generate();
        for _ in 0..(index-1) {
            generator.next()
        }
        return generator.next()
    }
    
    func get (range: Range<Int>) -> SequenceOf<T> {
        return self.skip(range.startIndex)
            .take(range.endIndex - range.startIndex)
    }
    
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
    
    func skip (n:Int) -> SequenceOf<T> {
        var generator =  self.generate();
        for _ in 0..n {
            generator.next()
        }
        return SequenceOf(generator)
    }
    
    func filter(includeElement: (T) -> Bool) -> SequenceOf<T> {
        return SequenceOf(FilterSequence(self, includeElement))
    }
    
    func reject (exclude: (T -> Bool)) -> SequenceOf<T> {
        return self.filter {
            return !exclude($0)
        }
    }
    
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
    
    func contains<T:Equatable> (item: T) -> Bool {
        var generator =  self.generate();
        while let nextItem = generator.next() {
            if nextItem as T == item {
                return true;
            }
        }
        return false
    }

    func take (n:Int) -> SequenceOf<T> {
        return SequenceOf(TakeSequence(self, n))
    }
    
    func takeWhile (condition:(T?) -> Bool) -> SequenceOf<T>  {
        return SequenceOf(TakeWhileSequence(self, condition))
    }
    
    //TODO: methods that make sense to add to sequence
    
    // unique <T: Equatable> ()
    // flatten <OutType> () -> OutType[]
    
    // DONE
    
    // reject (exclude: (Element -> Bool)) -> SequenceOf<Element>
    // any (call: (Element) -> Bool) -> Bool
    // get (range: Range<Int>) -> SequenceOf<T>
    // get (index: Int) -> Element?
    // indexOf <U: Equatable> (item: U) -> Int?
    // first () -> T?
    // takeWhile (condition:(Element?) -> Bool) -> SequenceOf<Element>
    // take (n:Int) -> SequenceOf<Element>
    // contains<T:Equatable> (item: T) -> Bool
    // skip (n:Int) -> SequenceOf<T>
    // skipWhile(condition:(T) -> Bool) -> SequenceOf<T>
}

// a sequence adapter that implements the 'filter' functionality
struct FilterSequence<S:Sequence>: Sequence {
    let sequence: S
    let includeElement: (S.GeneratorType.Element) -> Bool
    
    init(_ sequence: S, _ includeElement: (S.GeneratorType.Element) -> Bool) {
        self.sequence = sequence
        self.includeElement = includeElement
    }
    
    func generate() -> GeneratorOf<S.GeneratorType.Element> {
        var generator = self.sequence.generate()
        return GeneratorOf<S.GeneratorType.Element> {
            var keepSkipping = true
            var nextItem = generator.next()
            while keepSkipping {
                if let unwrappedItem = nextItem {
                    keepSkipping = !self.includeElement(unwrappedItem)
                } else {
                    keepSkipping = false
                }
                
                if (keepSkipping) {
                    nextItem = generator.next()
                }
            }
            return nextItem
        }
    }
}

// a sequence adapter that implements the 'take' functionality
struct TakeSequence<S:Sequence>: Sequence {
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
struct TakeWhileSequence<S:Sequence>: Sequence {
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