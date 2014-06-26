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
    
    func skip (n:Int) -> SequenceOf<T> {
        var generator =  self.generate();
        for _ in 0..n {
            generator.next()
        }
        return SequenceOf(generator)
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

// a sequence adapter that implements the 'take' functionality
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