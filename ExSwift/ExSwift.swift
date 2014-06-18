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

class Ex: ExSwift { }
class ExSwift {

    /**
    *  Returns a function `f: (P...) -> T?` that executes `call` only after being called `n` times.
    *  @param call Function to call after n times
    *  @return New function
    */
    class func after <P, T> (n: Int, call: (P...) -> T) -> ((P...) -> T?) {
        var times = n
        return {
            (params: (P...)) -> T? in
            
            if times-- <= 0 {
                return call(reinterpretCast(params))
            }
            
            return nil
        }
    }

    //  Wrapper for a zero params after
    class func after <T> (n: Int, call: Void -> T) -> (Void -> T?) {
        let f = ExSwift.after(n, call: {
            (params: (Any?...)) -> T? in
            return call()
        })

        return {
            return f(nil)?
        }
    }

    /**
    *  Returns a function `f: (P...) -> T?` that executes `call` once.
    *  @param call Function to call once
    *  @return New function
    */
    class func once <P, T> (call: (P...) -> T) -> ((P...) -> T?) {
        
        var executed = false
        
        return {
            (params: (P...)) -> T? in
            
            if (executed) {
                return nil
            }
            
            executed = true
            
            //  From P[] to P...
            return call(reinterpretCast(params))
            
        }
        
    }
    
    //  Wrapper for a zero params once
    class func once <T> (call: Void -> T) -> (Void -> T?) {
        let f = ExSwift.once {
            (params: Any?...) -> T? in
            return call()
        }

        return {
            return f(nil)?
        }
    }

    /**
     *  Creates a function that, when called, invokes function with any additional partial arguments prepended to those provided to the new function.
     *  @param function Function to call
     *  @param parameters Parameters to prepend
     *  @return New function
    */
    class func partial <P, T> (function: (P...) -> T, _ parameters: P...) -> ((P...) -> T) {
        
        return {
            (params: P...) -> T in
            return function(reinterpretCast(parameters + params))
        }
        
    }

    /**
    *  Creates a function that, when called, invokes function with `parameters`
    *  @param function Function to call
    *  @param parameters Parameters
    *  @return New function
    */
    class func bind <P, T> (function: (P...) -> T, _ parameters: P...) -> (Void -> T) {
        
        return {
            Void -> T in
            return function(reinterpretCast(parameters))
        }

    }
    
    /**
     *  Returns a NSRegularExpression object given a pattern
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
