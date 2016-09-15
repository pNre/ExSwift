//
//  ExSwift.swift
//  ExSwift
//
//  Created by pNre on 07/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

infix operator =~
infix operator |~
infix operator ..
infix operator <=>

public typealias Ex = ExSwift

open class ExSwift {
    
    /**
        Creates a wrapper that, executes function only after being called n times.
    
        - parameter n: No. of times the wrapper has to be called before function is invoked
        - parameter function: Function to wrap
        - returns: Wrapper function
    */
    open class func after <P, T> (_ n: Int, function: @escaping (P...) -> T) -> ((P...) -> T?) {
        
        typealias Function = ([P]) -> T
    
        var times = n
        
        return {
            (params: P...) -> T? in
            
            //  Workaround for the now illegal (T...) type.
            let adaptedFunction = unsafeBitCast(function, to: Function.self)
            times -= 1
            if times <= 0 {
                return adaptedFunction(params)
            }
            
            return nil
        }
        
    }
    
    /**
        Creates a wrapper that, executes function only after being called n times
    
        - parameter n: No. of times the wrapper has to be called before function is invoked
        - parameter function: Function to wrap
        - returns: Wrapper function
    */
    /*public class func after <T> (n: Int, function: Void -> T) -> (Void -> T?) {
        func callAfter (args: Any?...) -> T {
            return function()
        }
        
        let f = ExSwift.after(n, function: callAfter)
        
        return { f([nil]) }
    }*/
    
    /**
        Creates a wrapper function that invokes function once.
        Repeated calls to the wrapper function will return the value of the first call.
    
        - parameter function: Function to wrap
        - returns: Wrapper function
    */
    open class func once <P, T> (_ function: @escaping (P...) -> T) -> ((P...) -> T) {
        
        typealias Function = ([P]) -> T
    
        var returnValue: T? = nil
        
        return { (params: P...) -> T in
            
            if returnValue != nil {
                return returnValue!
            }
            
            let adaptedFunction = unsafeBitCast(function, to: Function.self)
            returnValue = adaptedFunction(params)
            
            return returnValue!

        }
        
    }
    
    /**
        Creates a wrapper function that invokes function once. 
        Repeated calls to the wrapper function will return the value of the first call.
    
        - parameter function: Function to wrap
        - returns: Wrapper function
    */
    /*public class func once <T> (function: Void -> T) -> (Void -> T) {
        let f = ExSwift.once {
            (params: Any?...) -> T in
            return function()
        }
        
        return { f([nil]) }
    }*/
    
    /**
        Creates a wrapper that, when called, invokes function with any additional 
        partial arguments prepended to those provided to the new function.

        - parameter function: Function to wrap
        - parameter parameters: Arguments to prepend
        - returns: Wrapper function
    */
    open class func partial <P, T> (_ function: @escaping (P...) -> T, _ parameters: P...) -> ((P...) -> T) {
        typealias Function = ([P]) -> T

        return { (params: P...) -> T in
            let adaptedFunction = unsafeBitCast(function, to: Function.self)
            return adaptedFunction(parameters + params)
        }
    }
    
    /**
        Creates a wrapper (without any parameter) that, when called, invokes function
        automatically passing parameters as arguments.
    
        - parameter function: Function to wrap
        - parameter parameters: Arguments to pass to function
        - returns: Wrapper function
    */
    open class func bind <P, T> (_ function: @escaping (P...) -> T, _ parameters: P...) -> ((Void) -> T) {
        typealias Function = ([P]) -> T

        return { Void -> T in
            let adaptedFunction = unsafeBitCast(function, to: Function.self)
            return adaptedFunction(parameters)
        }
    }
    
    /**
        Creates a wrapper for function that caches the result of function's invocations.
        
        - parameter function: Function with one parameter to cache
        - returns: Wrapper function
    */
    open class func cached <P: Hashable, R> (_ function: @escaping (P) -> R) -> ((P) -> R) {
        var cache = [P:R]()
        
        return { (param: P) -> R in
            let key = param
            
            if let cachedValue = cache[key] {
                return cachedValue
            } else {
                let value = function(param)
                cache[key] = value
                return value
            }
        }
    }
    
    /**
        Creates a wrapper for function that caches the result of function's invocations.
        
        - parameter function: Function to cache
        - parameter hash: Parameters based hashing function that computes the key used to store each result in the cache
        - returns: Wrapper function
    */
    open class func cached <P: Hashable, R> (_ function: @escaping (P...) -> R, hash: @escaping ((P...) -> P)) -> ((P...) -> R) {
        typealias Function = ([P]) -> R
        typealias Hash = ([P]) -> P
        
        var cache = [P:R]()
        
        return { (params: P...) -> R in
            let adaptedFunction = unsafeBitCast(function, to: Function.self)
            let adaptedHash = unsafeBitCast(hash, to: Hash.self)
            
            let key = adaptedHash(params)
            
            if let cachedValue = cache[key] {
                return cachedValue
            } else {
                let value = adaptedFunction(params)
                cache[key] = value
                return value
            }
        }
    }
    
    /**
        Creates a wrapper for function that caches the result of function's invocations.
    
        - parameter function: Function to cache
        - returns: Wrapper function
    */
    open class func cached <P: Hashable, R> (_ function: @escaping (P...) -> R) -> ((P...) -> R) {
        return cached(function, hash: { (params: P...) -> P in return params[0] })
    }
    
    /**
        Utility method to return an NSRegularExpression object given a pattern.
        
        - parameter pattern: Regex pattern
        - parameter ignoreCase: If true the NSRegularExpression is created with the NSRegularExpressionOptions.CaseInsensitive flag
        - returns: NSRegularExpression object
    */
    internal class func regex (_ pattern: String, ignoreCase: Bool = false) throws -> NSRegularExpression? {
        
        var options = NSRegularExpression.Options.dotMatchesLineSeparators.rawValue
        
        if ignoreCase {
            options = NSRegularExpression.Options.caseInsensitive.rawValue | options
        }

        return try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: options))
        
    }

}

func <=> <T: Comparable>(lhs: T, rhs: T) -> Int {
    if lhs < rhs {
        return -1
    } else if lhs > rhs {
        return 1
    } else {
        return 0
    }
}

/**
*  Internal methods
*/
extension ExSwift {
    
    /**
    *  Converts, if possible, and flattens an object from its Objective-C
    *  representation to the Swift one.
    *  @param object Object to convert
    *  @returns Flattenend array of converted values
    */
    internal class func bridgeObjCObject <T, S> (_ object: S) -> [T] {
        var result = [T]()
        let reflection = Mirror(reflecting: object)
        let mirrorChildrenCollection = AnyRandomAccessCollection(reflection.children)
        
        //  object has an Objective-C type
        if let obj = object as? T {
            //  object has type T
            result.append(obj)
        } else if reflection.subjectType == NSArray.self {
            
            //  If it is an NSArray, flattening will produce the expected result
            if let array = object as? NSArray {
                result += array.flatten()
            } else if let bridged = mirrorChildrenCollection as? T {
                result.append(bridged)
            }
            
        } else if object is Array<T> {
            //  object is a native Swift array
            
            //  recursively convert each item
            for (_, value) in mirrorChildrenCollection! {
                result += Ex.bridgeObjCObject(value)
            }
            
        }
        
        return result
    }
    
}
