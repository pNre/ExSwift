//
//  RawRepresentable.swift
//  ExSwift
//
//  Created by Alsey Coleman Miller on 2/6/15.
//  Copyright (c) 2015 pNre. All rights reserved.
//

import Foundation

/// Converts an array of RawRepresentable to its raw values.
public func RawValues<T: RawRepresentable>(rawRepresentableArray: [T]) -> [T.RawValue] {
    
    typealias rawValueType = T.RawValue
    
    var rawValues = [rawValueType]()
    
    for rawRepresentable in rawRepresentableArray {
        
        rawValues.append(rawRepresentable.rawValue)
    }
    
    return rawValues
}

// Creates an array of RawRepresentable from an array of raw values. Returns nil if an element in the array had an invalid raw value
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