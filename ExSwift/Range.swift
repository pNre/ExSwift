//
//  Range.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension CountableRange {

  /**
   For each element in the range invokes function.

   - parameter function: Function to call
   */
  public func times (_ function: () -> ()) {
    each { (current: Bound) -> () in
      function()
    }
  }

  /**
   For each element in the range invokes function passing the element as argument.

   - parameter function: Function to invoke
   */
  public func times (_ function: (Bound) -> ()) {
    each (function)
  }

  /**
   For each element in the range invokes function passing the element as argument.

   - parameter function: Function to invoke
   */
  public func each (_ function: (Bound) -> ()) {
    for i in self {
      function(i)
    }
  }

  /**
   Returns each element of the range in an array

   - returns: Each element of the range in an array
   */
  public func toArray () -> [Bound] {
    var result: [Bound] = []
    for i in self {
      result.append(i)
    }
    return result
  }

  /**
   Range of Int with random bounds between from and to (inclusive).

   - parameter from: Lower bound
   - parameter to: Upper bound
   - returns: Random range
   */
  public static func random (_ from: Int, to: Int) -> CountableClosedRange<Int> {
    let lowerBound = Int.random(from, max: to)
    let upperBound = Int.random(lowerBound, max: to)

    return lowerBound...upperBound
  }

}

public extension CountableClosedRange {

  /**
   For each element in the range invokes function.

   - parameter function: Function to call
   */
  public func times (_ function: () -> ()) {
    each { (current: Bound) -> () in
      function()
    }
  }

  /**
   For each element in the range invokes function passing the element as argument.

   - parameter function: Function to invoke
   */
  public func times (_ function: (Bound) -> ()) {
    each (function)
  }

  /**
   For each element in the range invokes function passing the element as argument.

   - parameter function: Function to invoke
   */
  public func each (_ function: (Bound) -> ()) {
    for i in self {
      function(i)
    }
  }

  /**
   Returns each element of the range in an array

   - returns: Each element of the range in an array
   */
  public func toArray () -> [Bound] {
    var result: [Bound] = []
    for i in self {
      result.append(i)
    }
    return result
  }

  /**
   Range of Int with random bounds between from and to (inclusive).

   - parameter from: Lower bound
   - parameter to: Upper bound
   - returns: Random range
   */
  public static func random (_ from: Int, to: Int) -> CountableClosedRange<Int> {
    let lowerBound = Int.random(from, max: to)
    let upperBound = Int.random(lowerBound, max: to)

    return lowerBound...upperBound
  }

}

/**
 *  Operator == to compare 2 ranges first, second by start & end indexes. If first.startIndex is equal to
 *  second.startIndex and first.endIndex is equal to second.endIndex the ranges are considered equal.
 */
public func == <U: Comparable> (first: Range<U>, second: Range<U>) -> Bool {
  return first.lowerBound == second.lowerBound &&
    first.upperBound == second.upperBound
}
