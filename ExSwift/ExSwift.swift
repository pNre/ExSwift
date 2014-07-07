//
//  ExSwift.swift
//  ExSwift
//
//  Created by pNre on 07/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

operator infix =~ {}
operator infix |~ {}

typealias Ex = ExSwift

class ExSwift {
    
    /**
    *  Creates a wrapper that, executes function only after being called n times
    *  @param n No. of times the wrapper has to be called before function is invoked
    *  @param function Function to wrap
    *  @return Wrapper function
    */
    class func after <P, T> (n: Int, function: (P...) -> T) -> ((P...) -> T?) {
        var times = n
        return {
            (params: (P...)) -> T? in
            
            if times-- <= 0 {
                return function(reinterpretCast(params))
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
    class func after <T> (n: Int, function: Void -> T) -> (Void -> T?) {
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
    class func once <P, T> (function: (P...) -> T) -> ((P...) -> T?) {
        
        var executed = false
        
        return {
            (params: (P...)) -> T? in
            
            if (executed) {
                return nil
            }
            
            executed = true
            
            //  From P[] to P...
            return function(reinterpretCast(params))
            
        }
        
    }
    
    /**
    *  Creates a wrapper that, when called for the first time (only) invokes function
    *  @param function Function to wrap
    *  @return Wrapper function
    */
    class func once <T> (function: Void -> T) -> (Void -> T?) {
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
    class func partial <P, T> (function: (P...) -> T, _ parameters: P...) -> ((P...) -> T) {
        
        return {
            (params: P...) -> T in
            return function(reinterpretCast(parameters + params))
        }
        
    }
    
    /**
    *  Creates a wrapper (without any parameter) that, when called, invokes function automatically passing parameters as arguments
    *  @param function Function to wrap
    *  @param parameters Arguments to pass to function
    *  @return Wrapper function
    */
    class func bind <P, T> (function: (P...) -> T, _ parameters: P...) -> (Void -> T) {
        
        return {
            Void -> T in
            return function(reinterpretCast(parameters))
        }
        
    }
    
    /**
    *  Creates a wrapper for function that caches the result of function's invocations.
    *  @param function Function to cache
    *  @param hash Parameters based hashing function that computes the key used to store each result in the cache
    *  @return Wrapper function
    */
    class func cached <P, R> (function: (P...) -> R, hash: ((P...) -> P)) -> ((P...) -> R) {
        var cache = NSCache()
        
        return {
            (params: P...) -> R in
            
            let paramsList = reinterpretCast(params) as (P...)
            let bridgedKey : AnyObject? = bridgeToObjectiveC(hash(paramsList))
            
            //  If hash doesn't return any value, forget caching
            if !bridgedKey {
                return function(paramsList)
            }
            
            if let cachedValue : AnyObject = cache.objectForKey(bridgedKey) {
                return bridgeFromObjectiveC(cachedValue, R.self)
            }
            
            let result = function(paramsList)
            cache.setObject(bridgeToObjectiveC(result), forKey: bridgedKey)
            
            return result
        }
    }
    
    /**
    *  Creates a wrapper for function that caches the result of function's invocations.
    *  @param function Function to cache
    *  @return Wrapper function
    */
    class func cached <P, R> (function: (P...) -> R) -> ((P...) -> R) {
        return cached(function, hash: { (params: P...) -> P in return params[0] })
    }
    
    /**
    *  Utility method to return an NSRegularExpression object given a pattern.
    *  @param pattern Regex pattern
    *  @param ignoreCase If true the NSRegularExpression is created with the NSRegularExpressionOptions.CaseInsensitive flag
    *  @return NSRegularExpression object
    */
    class func regex (pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
        
        var options: NSRegularExpressionOptions = NSRegularExpressionOptions.DotMatchesLineSeparators
        
        if ignoreCase {
            options = NSRegularExpressionOptions.CaseInsensitive | options
        }
        
        var error: NSError? = nil
        let regex = NSRegularExpression.regularExpressionWithPattern(pattern, options: options, error: &error)
        
        return (error == nil) ? regex : nil
        
    }
    
}
