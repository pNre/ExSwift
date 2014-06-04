//
//  Array.swift
//  ExSwift
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
    
    /**
    *  Randomly rearranges the elements of self using the Fisher-Yates shuffle
    */
    func shuffle () {
        
        for var i = self.count - 1; i >= 1; i-- {
            var j = Int.random(max: i)
            var temp = self[j]
            self[j] = self[i]
            self[i] = temp
        }
        
    }
    
    /**
    *  Creates an array of shuffled values
    *  @return Shuffled copy of self
    */
    func shuffled () -> Array<T> {
        var shuffled = self.copy()
        
        //  The shuffling is done using the Fisher-Yates shuffle
        for i in 0..self.count {
            var j = Int.random(max: i)
            if j != i {
                shuffled[i] = shuffled[j]
            }
            shuffled[j] = self[i]
        }
        
        return shuffled
    }
    
    /**
    *  Returns a random subarray of length n
    *  @param n Length
    *  @return Random subarray of length n
    */
    func sample (size n: Int = 1) -> Array<T> {
        var index = Int.random(max: count - n)
        return self[index..(n + index)]
    }

    /**
    *  Returns a subarray in the given range
    *  @return Subarray or nil if the index is out of bounds
    */
    subscript (range: Range<Int>) -> Array<T> {
        var subarray = Array<T>()
            
        for var i = range.startIndex; i < range.endIndex; i++ {
            subarray += [self[i]]
        }
            
        return subarray
    }
    
    /**
    *  Returns the max value in the current array
    *  @return Max value
    */
    func max <T: Comparable> () -> T {

        //  Find a better way to do this
        
        var max = self.first() as? T
        
        for i in 1..count {
            
            if var current = self.get(i) as? T {
            
                if current > max {
                    max = current
                }
            
            }
            
        }
        
        //  The max is not compatible with T
        assert(max)
        
        return max!
  
    }
    
    /**
    *  Returns the min value in the current array
    *  @return Min value
    */
    func min <T: Comparable> () -> T {
        
        //  Find a better way to do this
        
        var min = self.first() as? T
        
        for i in 1..count {
            
            if var current = self.get(i) as? T {
                
                if current < min {
                    min = current
                }
                
            }
            
        }
        
        //  The max is not compatible with T
        assert(min)
        
        return min!
        
    }
    
}

/**
*  Shorthand for the array difference
*/
@infix func - <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.difference(second)
}

