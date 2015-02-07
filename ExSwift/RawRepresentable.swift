//
//  RawRepresentable.swift
//  ExSwift
//
//  Created by Alsey Coleman Miller on 2/6/15.
//  Copyright (c) 2015 pNre. All rights reserved.
//

import Foundation

/**
    Converts an array of RawRepresentable to its raw values.
    
    :param: rawRepresentableArray Array of RawRepresentable whose raw values will be extracted into an array.
    :returns: An array of raw values extracted from the RawRepresentable array.
*/
public func RawValues<T: RawRepresentable>(rawRepresentableArray: [T]) -> [T.RawValue] {
    
    typealias rawValueType = T.RawValue
    
    var rawValues = [rawValueType]()
    
    for rawRepresentable in rawRepresentableArray {
        
        rawValues.append(rawRepresentable.rawValue)
    }
    
    return rawValues
}

/**
    Creates an array of RawRepresentable from an array of raw values. Returns nil if an element in the array had an invalid raw value.

    :param: rawRepresentableType The type of the RawRepresentable that will be created from the array of raw values.
    :param: rawValues An array of raw values that will be used to create the array of RawRepresentable
    :returns: An array of RawRepresentable from the array of raw values. Returns nil if an element in the array had an invalid raw value.
*/
public func RawRepresentables<T: RawRepresentable>(rawRepresentableType: T.Type, rawValues: [T.RawValue]) -> [T]? {
    
    typealias rawValueType = T.RawValue
    
    var representables = [T]()
    
    for rawValue in rawValues {
        
        let rawRepresentable = T(rawValue: rawValue)
        
        if rawRepresentable == nil {
            
            return nil
        }
        
        representables.append(rawRepresentable!)
    }
    
    return representables
}
