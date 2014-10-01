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
        Creates a wrapper that, executes function only after being called n times.
    
        :param: n No. of times the wrapper has to be called before function is invoked
        :param: function Function to wrap
        :returns: Wrapper function
    */
    public class func after <P, T> (n: Int, function: (P...) -> T) -> ((P...) -> T?) {
        
        typealias Function = [P] -> T
    
        var times = n
        
        return {
            (params: P...) -> T? in
            
            //  Workaround for the now illegal (T...) type.
            let adaptedFunction = unsafeBitCast(function, Function.self)
        
            if times-- <= 0 {
                return adaptedFunction(params)
            }
            
            return nil
        }
        
    }
    
    /**
        Creates a wrapper that, executes function only after being called n times
    
        :param: n No. of times the wrapper has to be called before function is invoked
        :param: function Function to wrap
        :returns: Wrapper function
    */
    public class func after <T> (n: Int, function: Void -> T) -> (Void -> T?) {
        func callAfter (args: Any?...) -> T {
            return function()
        }
        
        let f = ExSwift.after(n, function: callAfter)
        
        return { f([nil])? }
    }
    
    /**
        Creates a wrapper function that invokes function once.
        Repeated calls to the wrapper function will return the value of the first call.
    
        :param: function Function to wrap
        :returns: Wrapper function
    */
    public class func once <P, T> (function: (P...) -> T) -> ((P...) -> T) {
        
        typealias Function = [P] -> T
    
        var returnValue: T? = nil
        
        return { (params: P...) -> T in
            
            if returnValue != nil {
                return returnValue!
            }
            
            let adaptedFunction = unsafeBitCast(function, Function.self)
            returnValue = adaptedFunction(params)
            
            return returnValue!

        }
        
    }
    
    /**
        Creates a wrapper function that invokes function once. 
        Repeated calls to the wrapper function will return the value of the first call.
    
        :param: function Function to wrap
        :returns: Wrapper function
    */
    public class func once <T> (function: Void -> T) -> (Void -> T) {
        let f = ExSwift.once {
            (params: Any?...) -> T in
            return function()
        }
        
        return { f([nil]) }
    }
    
    /**
        Creates a wrapper that, when called, invokes function with any additional 
        partial arguments prepended to those provided to the new function.

        :param: function Function to wrap
        :param: parameters Arguments to prepend
        :returns: Wrapper function
    */
    public class func partial <P, T> (function: (P...) -> T, _ parameters: P...) -> ((P...) -> T) {
        typealias Function = [P] -> T

        return { (params: P...) -> T in
            let adaptedFunction = unsafeBitCast(function, Function.self)
            return adaptedFunction(parameters + params)
        }
    }
    
    /**
        Creates a wrapper (without any parameter) that, when called, invokes function
        automatically passing parameters as arguments.
    
        :param: function Function to wrap
        :param: parameters Arguments to pass to function
        :returns: Wrapper function
    */
    public class func bind <P, T> (function: (P...) -> T, _ parameters: P...) -> (Void -> T) {
        typealias Function = [P] -> T

        return { Void -> T in
            let adaptedFunction = unsafeBitCast(function, Function.self)
            return adaptedFunction(parameters)
        }
    }
    
    /**
        Creates a wrapper for function that caches the result of function's invocations.
        
        :param: function Function to cache
        :param: hash Parameters based hashing function that computes the key used to store each result in the cache
        :returns: Wrapper function
    */
    public class func cached <P: Hashable, R> (function: (P...) -> R, hash: ((P...) -> P)) -> ((P...) -> R) {
        typealias Function = [P] -> R
        typealias Hash = [P] -> P
        
        var cache = [P:R]()
        
        return { (params: P...) -> R in
            
            let adaptedFunction = unsafeBitCast(function, Function.self)
            let adaptedHash = unsafeBitCast(hash, Hash.self)
            
            let key = adaptedHash(params)
            
            if let cachedValue = cache[key] {
                return cachedValue
            }
            
            cache[key] = adaptedFunction(params)
            
            return cache[key]!
        }
    }
    
    /**
        Creates a wrapper for function that caches the result of function's invocations.
    
        :param: function Function to cache
        :returns: Wrapper function
    */
    public class func cached <P: Hashable, R> (function: (P...) -> R) -> ((P...) -> R) {
        return cached(function, hash: { (params: P...) -> P in return params[0] })
    }
    
    /**
        Utility method to return an NSRegularExpression object given a pattern.
        
        :param: pattern Regex pattern
        :param: ignoreCase If true the NSRegularExpression is created with the NSRegularExpressionOptions.CaseInsensitive flag
        :returns: NSRegularExpression object
    */
    internal class func regex (pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
        
        var options = NSRegularExpressionOptions.DotMatchesLineSeparators.rawValue
        
        if ignoreCase {
            options = NSRegularExpressionOptions.CaseInsensitive.rawValue | options
        }

        var error: NSError? = nil
        let regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: options), error: &error)
            
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
        if let obj = object as? T {
            //  object has type T
            result.append(obj)
        } else if reflection.disposition == .ObjCObject {
            
            var bridgedValue: T!?

            //  If it is an NSArray, flattening will produce the expected result
            if let array = object as? NSArray {
                result += array.flatten()
            } else if let bridged = reflection.value as? T {
                result.append(bridged)
            }
        } else if reflection.disposition == .IndexContainer {
            //  object is a native Swift array
            
            //  recursively convert each item
            (0..<reflection.count).each {
                let ref = reflection[$0].1

                result += Ex.bridgeObjCObject(ref.value)
            }
            
        }
        
        return result
    }
    
}
