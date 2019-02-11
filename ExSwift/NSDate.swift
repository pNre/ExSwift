//
//  File.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 23/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Date {

  // MARK:  NSDate Manipulation

  /**
   Returns a new NSDate object representing the date calculated by adding the amount specified to self date

   - parameter seconds: number of seconds to add
   - parameter minutes: number of minutes to add
   - parameter hours: number of hours to add
   - parameter days: number of days to add
   - parameter weeks: number of weeks to add
   - parameter months: number of months to add
   - parameter years: number of years to add
   - returns: the NSDate computed
   */
  public func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> Date {
    let calendar = Calendar.current
    let version = floor(NSFoundationVersionNumber)

    if version <= NSFoundationVersionNumber10_9_2 {
      var component = DateComponents()
      component.setValue(seconds, for: .second)

      var date : Date! = calendar.date(byAdding: component, to: self, wrappingComponents: false)!
      component = DateComponents()
      component.setValue(minutes, for: .minute)
      date = calendar.date(byAdding: component, to: date, wrappingComponents: false)!

      component = DateComponents()
      component.setValue(hours, for: .hour)
      date = calendar.date(byAdding: component, to: date, wrappingComponents: false)!

      component = DateComponents()
      component.setValue(days, for: .day)
      date = calendar.date(byAdding: component, to: date, wrappingComponents: false)!

      component = DateComponents()
      component.setValue(weeks, for: .weekOfMonth)
      date = calendar.date(byAdding: component, to: date, wrappingComponents: false)!

      component = DateComponents()
      component.setValue(months, for: .month)
      date = calendar.date(byAdding: component, to: date, wrappingComponents: false)!

      component = DateComponents()
      component.setValue(years, for: .year)
      date = calendar.date(byAdding: component, to: date, wrappingComponents: false)!
      return date
    }

    var date : Date! = calendar.date(byAdding: Calendar.Component.second, value: seconds, to: self, wrappingComponents: false)
    date = calendar.date(byAdding: Calendar.Component.minute, value: minutes, to: date, wrappingComponents: false)
    date = calendar.date(byAdding: Calendar.Component.day, value: days, to: date, wrappingComponents: false)
    date = calendar.date(byAdding: Calendar.Component.hour, value: hours, to: date, wrappingComponents: false)
    date = calendar.date(byAdding: Calendar.Component.weekOfMonth, value: weeks, to: date, wrappingComponents: false)
    date = calendar.date(byAdding: Calendar.Component.month, value: months, to: date, wrappingComponents: false)
    date = calendar.date(byAdding: Calendar.Component.year, value: years, to: date, wrappingComponents: false)
    return date
  }

  /**
   Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date

   - parameter seconds: number of seconds to add
   - returns: the NSDate computed
   */
  public func addSeconds (_ seconds: Int) -> Date {
    return add(seconds: seconds)
  }

  /**
   Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date

   - parameter minutes: number of minutes to add
   - returns: the NSDate computed
   */
  public func addMinutes (_ minutes: Int) -> Date {
    return add(minutes: minutes)
  }

  /**
   Returns a new NSDate object representing the date calculated by adding an amount of hours to self date

   - parameter hours: number of hours to add
   - returns: the NSDate computed
   */
  public func addHours(_ hours: Int) -> Date {
    return add(hours: hours)
  }

  /**
   Returns a new NSDate object representing the date calculated by adding an amount of days to self date

   - parameter days: number of days to add
   - returns: the NSDate computed
   */
  public func addDays(_ days: Int) -> Date {
    return add(days: days)
  }

  /**
   Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date

   - parameter weeks: number of weeks to add
   - returns: the NSDate computed
   */
  public func addWeeks(_ weeks: Int) -> Date {
    return add(weeks: weeks)
  }


  /**
   Returns a new NSDate object representing the date calculated by adding an amount of months to self date

   - parameter months: number of months to add
   - returns: the NSDate computed
   */

  public func addMonths(_ months: Int) -> Date {
    return add(months: months)
  }

  /**
   Returns a new NSDate object representing the date calculated by adding an amount of years to self date

   - parameter years: number of year to add
   - returns: the NSDate computed
   */
  public func addYears(_ years: Int) -> Date {
    return add(years: years)
  }

  // MARK:  Date comparison

  /**
   Checks if self is after input NSDate

   - parameter date: NSDate to compare
   - returns: True if self is after the input NSDate, false otherwise
   */
  public func isAfter(_ date: Date) -> Bool{
    return (self.compare(date) == ComparisonResult.orderedDescending)
  }

  /**
   Checks if self is before input NSDate

   - parameter date: NSDate to compare
   - returns: True if self is before the input NSDate, false otherwise
   */
  public func isBefore(_ date: Date) -> Bool{
    return (self.compare(date) == ComparisonResult.orderedAscending)
  }


  // MARK: Getter

  /**
   Date year
   */
  public var year : Int {
    get {
      return getComponent(.year)
    }
  }

  /**
   Date month
   */
  public var month : Int {
    get {
      return getComponent(.month)
    }
  }

  /**
   Date weekday
   */
  public var weekday : Int {
    get {
      return getComponent(.weekday)
    }
  }

  /**
   Date weekMonth
   */
  public var weekMonth : Int {
    get {
      return getComponent(.weekOfMonth)
    }
  }


  /**
   Date days
   */
  public var days : Int {
    get {
      return getComponent(.day)
    }
  }

  /**
   Date hours
   */
  public var hours : Int {

    get {
      return getComponent(.hour)
    }
  }

  /**
   Date minuts
   */
  public var minutes : Int {
    get {
      return getComponent(.minute)
    }
  }

  /**
   Date seconds
   */
  public var seconds : Int {
    get {
      return getComponent(.second)
    }
  }

  /**
   Returns the value of the NSDate component

   - parameter component: NSCalendarUnit
   - returns: the value of the component
   */

  public func getComponent (_ component : Calendar.Component) -> Int {
    let calendar = Calendar.current
    return calendar.component(component, from: self)
  }
}

extension Date: Strideable {
  public func distance(to other: Date) -> TimeInterval {
    return other - self
  }

  public func advanced(by n: TimeInterval) -> Date {
    return type(of: self).init(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate + n)
  }
}
// MARK: Arithmetic

public func +(date: Date, timeInterval: Int) -> Date {
  return date + Double(timeInterval)
}

public func -(date: Date, timeInterval: Int) -> Date {
  return date - Double(timeInterval)
}

public func +=(date: inout Date, timeInterval: Int) {
  date = date + timeInterval
}

public func -=(date: inout Date, timeInterval: Int) {
  date = date - timeInterval
}

public func -(date: Date, otherDate: Date) -> TimeInterval {
  return date.timeIntervalSince(otherDate)
}
