//
//  Array.swift
//  Extensions
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension Array {
    
    /**
     *  Checks if self contains the item object
     *  @param item The item to search for
     *  @return true if self contains item
     */
    func contains <T: Equatable> (item: T) -> Bool {
        return indexOf(item) >= 0
    }
    
    /**
    *  Computes the difference between self and the input arrays
    *  @param values Arrays to subtract
    *  @return Difference between self and the input arrays
    */
    func difference <T: Equatable> (values: Array<T>...) -> Array<T> {
        
        var result = Array<T>()
        
        elements: for e in self {
            if let element = e as? T {
                for value in values {
                    //  if a value is in both self and one of the values arrays
                    //  jump to the next iteration of the outer loop
                    if value.contains(element) {
                        continue elements
                    }
                }
                
                //  element it's only in self
                result.append(element)
            }
        }
        
        return result
        
    }
    
    /**
    *  Computes the intersection between self and the input arrays
    *  @param values Arrays to intersect
    *  @return Array of unique values present in all the values arrays + self
    */
    func intersection <U: Equatable> (values: Array<U>...) -> Array<T> {
        
        var result: Array<T> = self as Array<T>
        var intersection = Array<T>()
        
        for i in 0..values.count {
            
            //  the intersection is computed by intersecting a couple per loop:
            //  self n values[0], (self n values[0]) n values[1], ...
            if (i > 0) {
                result = intersection.copy()
                intersection = Array<T>()
            }
            
            //  find common elements and save them in first set
            //  to intersect in the next loop
            for item in values[i] {
                if result.contains(item) {
                    intersection.append(item as T)
                }
            }
            
        }
        
        return intersection
        
    }
    
    /**
    *  Gets the first element of the array
    *  @return First element of the array
    */
    func first () -> T? {
        if count > 0 {
            return self[0]
        }
        return nil
    }
    
    /**
    *  Gets the last element of the array
    *  @return Last element of the array
    */
    func last () -> T? {
        if count > 0 {
            return self[count - 1]
        }
        return nil
    }
    
    /**
    *  Gets the index at which the first occurrence of item is found
    *  @param item The item to search for
    *  @return Index of the matched item or -1
    */
    func indexOf <T: Equatable> (item: T) -> Int {
        
        for i in 0..count {
            if let object = self[i] as? T {
                if object == item {
                    return i
                }
            }
        }
        
        return -1
        
    }
    
    /**
    *  Gets the object at the specified index if exists
    *  @param index
    *  @return Object at index in array, nil if index is out of bounds
    */
    func get (index: Int) -> T? {
        return index < count ? self[index] : nil
    }
    
    /**
    *  Creates an array of grouped elements, the first of which contains the first elements of the given arrays, the 2nd contains the 2nd elements of the given arrays, and so on
    *  @param arrays Arrays to zip
    *  @return Array of grouped elements
    */
    func zip (arrays: Array<Any>...) -> Array<Array<Any?>> {

        var result = Array<Array<Any?>>()
        
        //  Gets the longest array
        var max = arrays.reduce(count, combine: {
            (max: Int, item: Array<Any>) -> Int in
            return item.count > max ? item.count : max;
        })
        
        for i in 0..max {
            var item = Array<Any?>()
            
            item.append(get(i))
            
            for array in arrays {
                item.append(array.get(i))
            }
            
            result.append(item)
        
        }
        
        return result
        
    }

    
}

@infix func - <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.difference(second)
}

