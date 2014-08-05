//
//  ExSwift.swift
//  ExSwift
//
//  Created by pNre on 07/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

infix operator =~ {}
infix operator |~ {}
infix operator .. {}

public typealias Ex = ExSwift

public class ExSwift {
    
    /**
    *  Creates a wrapper that, executes function only after being called n times
    *  @param n No. of times the wrapper has to be called before function is invoked
    *  @param function Function to wrap
    *  @return Wrapper function
    */
    public class func after <P, T> (n: Int, function: (P...) -> T) -> ((P...) -> T?) {
        var times = n
        return {
            (params: (P...)) -> T? in
            
            typealias ParamsType = (P...)
            
            if times-- <= 0 {
                return function(unsafeBitCast(params, ParamsType.self))
            }
            
            return nil
        }
    }
    
    /**
    *  Creates a wrapper that, executes function only after being called n times
    *  @param n No. of times the wrapper has to be called before function is invoked
    *  @param function Function to wrap
    *  @return Wrapper function
    */
    public class func after <T> (n: Int, function: Void -> T) -> (Void -> T?) {
        func callAfter (args: Any?...) -> T {
            return function()
        }
        
        let f = ExSwift.after(n, function: callAfter)
        
        return { f([nil])? }
    }
    
    /**
    *  Creates a wrapper that, when called for the first time (only) invokes function
    *  @param function Function to wrap
    *  @return Wrapper function
    */
    public class func once <P, T> (function: (P...) -> T) -> ((P...) -> T?) {
        
        var executed = false
        
        return {
            (params: (P...)) -> T? in
            
            typealias ParamsType = (P...)
            
            if (executed) {
                return nil
            }
            
            executed = true
            
            //  From P[] to P...
            return function(unsafeBitCast(params, ParamsType.self))
            
        }
        
    }
    
    /**
    *  Creates a wrapper that, when called for the first time (only) invokes function
    *  @param function Function to wrap
    *  @return Wrapper function
    */
    public class func once <T> (function: Void -> T) -> (Void -> T?) {
        let f = ExSwift.once {
            (params: Any?...) -> T? in
            return function()
        }
        
        return { f([nil])? }
    }
    
    /**
    *  Creates a wrapper that, when called, invokes function with any additional partial arguments prepended to those provided to the new function
    *  @param function Function to wrap
    *  @param parameters Arguments to prepend
    *  @return Wrapper function
    */
    public class func partial <P, T> (function: (P...) -> T, _ parameters: P...) -> ((P...) -> T) {
        
        return {
            (params: P...) -> T in
            
            typealias ParamsType = (P...)
            
            return function(unsafeBitCast(parameters + params, ParamsType.self))
        }
        
    }
    
    /**
    *  Creates a wrapper (without any parameter) that, when called, invokes function automatically passing parameters as arguments
    *  @param function Function to wrap
    *  @param parameters Arguments to pass to function
    *  @return Wrapper function
    */
    public class func bind <P, T> (function: (P...) -> T, _ parameters: P...) -> (Void -> T) {
        
        return {
            Void -> T in
            
            typealias ParamsType = (P...)
            
            return function(unsafeBitCast(parameters, ParamsType.self))
        }
        
    }
    
    /**
    *  Creates a wrapper for function that caches the result of function's invocations.
    *  @param function Function to cache
    *  @param hash Parameters based hashing function that computes the key used to store each result in the cache
    *  @return Wrapper function
    */
    public class func cached <P: Hashable, R> (function: (P...) -> R, hash: ((P...) -> P)) -> ((P...) -> R) {
        var cache = [P:R]()
        
        return {
            (params: P...) -> R in
            
            typealias ParamsType = (P...)
            
            let paramsList = unsafeBitCast(params, ParamsType.self)
            let key = hash(paramsList)
            
            if let cachedValue = cache[key] {
                return cachedValue
            }
            
            cache[key] = function(paramsList)
            
            return cache[key]!
        }
    }
    
    /**
    *  Creates a wrapper for function that caches the result of function's invocations.
    *  @param function Function to cache
    *  @return Wrapper function
    */
    public class func cached <P: Hashable, R> (function: (P...) -> R) -> ((P...) -> R) {
        return cached(function, hash: { (params: P...) -> P in return params[0] })
    }
    
    /**
    *  Utility method to return an NSRegularExpression object given a pattern.
    *  @param pattern Regex pattern
    *  @param ignoreCase If true the NSRegularExpression is created with the NSRegularExpressionOptions.CaseInsensitive flag
    *  @return NSRegularExpression object
    */
    public class func regex (pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
        
        var options: NSRegularExpressionOptions = NSRegularExpressionOptions.DotMatchesLineSeparators
        
        if ignoreCase {
            options = NSRegularExpressionOptions.CaseInsensitive | options
        }
        
        var error: NSError? = nil
        let regex = NSRegularExpression.regularExpressionWithPattern(pattern, options: options, error: &error)
        
        return (error == nil) ? regex : nil
        
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
    internal class func bridgeObjCObject <T, S> (object: S) -> [T] {
        var result = [T]()
        let reflection = reflect(object)
        
        //  object has an Objective-C type
        if reflection.disposition == .ObjCObject {
            //  If it is an NSArray, flattening will produce the expected result
            if let array = object as? NSArray {
                result += array.flatten()
            } else if let bridgedValue = ImplicitlyUnwrappedOptional<T>._bridgeFromObjectiveCConditional(reflection.value as NSObject) {
                //  the object type can be converted to the Swift native type T
                result.append(bridgedValue)
            }
        } else if reflection.disposition == .IndexContainer {
            //  object is a native Swift array
            
            //  recursively convert each item
            (0..<reflection.count).each {
                result += Ex.bridgeObjCObject(reflection[$0].1.value)
            }
            
        } else if let obj = object as? T {
            //  object has type T
            result.append(obj)
        }
        
        return result
    }
    
}
