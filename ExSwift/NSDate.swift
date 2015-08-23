//
//  File.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 23/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension NSDate {
    
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
    public func add(seconds seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let version = floor(NSFoundationVersionNumber)
    
        if version <= NSFoundationVersionNumber10_9_2 {
            var component = NSDateComponents()
            component.setValue(seconds, forComponent: .Second)
            
            var date : NSDate! = calendar.dateByAddingComponents(component, toDate: self, options: [])!
            component = NSDateComponents()
            component.setValue(minutes, forComponent: .Minute)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(hours, forComponent: .Hour)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(days, forComponent: .Day)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(weeks, forComponent: .WeekOfMonth)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(months, forComponent: .Month)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            
            component = NSDateComponents()
            component.setValue(years, forComponent: .Year)
            date = calendar.dateByAddingComponents(component, toDate: date, options: [])!
            return date
        }
    
        let options = NSCalendarOptions(rawValue: 0)
        var date : NSDate! = calendar.dateByAddingUnit(NSCalendarUnit.Second, value: seconds, toDate: self, options: options)
        date = calendar.dateByAddingUnit(NSCalendarUnit.Minute, value: minutes, toDate: date, options: options)
        date = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: days, toDate: date, options: options)
        date = calendar.dateByAddingUnit(NSCalendarUnit.Hour, value: hours, toDate: date, options: options)
        date = calendar.dateByAddingUnit(NSCalendarUnit.WeekOfMonth, value: weeks, toDate: date, options: options)
        date = calendar.dateByAddingUnit(NSCalendarUnit.Month, value: months, toDate: date, options: options)
        date = calendar.dateByAddingUnit(NSCalendarUnit.Year, value: years, toDate: date, options: options)
        return date
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
    
        - parameter seconds: number of seconds to add
        - returns: the NSDate computed
    */
    public func addSeconds (seconds: Int) -> NSDate {
        return add(seconds: seconds)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
    
        - parameter minutes: number of minutes to add
        - returns: the NSDate computed
    */
    public func addMinutes (minutes: Int) -> NSDate {
        return add(minutes: minutes)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
    
        - parameter hours: number of hours to add
        - returns: the NSDate computed
    */
    public func addHours(hours: Int) -> NSDate {
        return add(hours: hours)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of days to self date
    
        - parameter days: number of days to add
        - returns: the NSDate computed
    */
    public func addDays(days: Int) -> NSDate {
        return add(days: days)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
    
        - parameter weeks: number of weeks to add
        - returns: the NSDate computed
    */
    public func addWeeks(weeks: Int) -> NSDate {
        return add(weeks: weeks)
    }
    
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of months to self date
    
        - parameter months: number of months to add
        - returns: the NSDate computed
    */
    
    public func addMonths(months: Int) -> NSDate {
        return add(months: months)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of years to self date
    
        - parameter years: number of year to add
        - returns: the NSDate computed
    */
    public func addYears(years: Int) -> NSDate {
        return add(years: years)
    }
    
    // MARK:  Date comparison
    
    /**
        Checks if self is after input NSDate
    
        - parameter date: NSDate to compare
        - returns: True if self is after the input NSDate, false otherwise
    */
    public func isAfter(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedDescending)
    }
    
    /**
        Checks if self is before input NSDate
    
        - parameter date: NSDate to compare
        - returns: True if self is before the input NSDate, false otherwise
    */
    public func isBefore(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedAscending)
    }
    
    
    // MARK: Getter
    
    /**
        Date year
    */
    public var year : Int {
        get {
            return getComponent(.Year)
        }
    }

    /**
        Date month
    */
    public var month : Int {
        get {
            return getComponent(.Month)
        }
    }
    
    /**
        Date weekday
    */
    public var weekday : Int {
        get {
            return getComponent(.Weekday)
        }
    }

    /**
        Date weekMonth
    */
    public var weekMonth : Int {
        get {
            return getComponent(.WeekOfMonth)
        }
    }

    
    /**
        Date days
    */
    public var days : Int {
        get {
            return getComponent(.Day)
        }
    }
    
    /**
        Date hours
    */
    public var hours : Int {
        
        get {
            return getComponent(.Hour)
        }
    }
    
    /**
        Date minuts
    */
    public var minutes : Int {
        get {
            return getComponent(.Minute)
        }
    }
    
    /**
        Date seconds
    */
    public var seconds : Int {
        get {
            return getComponent(.Second)
        }
    }
    
    /**
        Returns the value of the NSDate component
    
        - parameter component: NSCalendarUnit
        - returns: the value of the component
    */

    public func getComponent (component : NSCalendarUnit) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(component, fromDate: self)

        return components.valueForComponent(component)
    }
}

extension NSDate: Strideable {
    public func distanceTo(other: NSDate) -> NSTimeInterval {
        return other - self
    }
    
    public func advancedBy(n: NSTimeInterval) -> Self {
        return self.dynamicType.init(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate + n)
    }
}
// MARK: Arithmetic

func +(date: NSDate, timeInterval: Int) -> NSDate {
    return date + NSTimeInterval(timeInterval)
}

func -(date: NSDate, timeInterval: Int) -> NSDate {
    return date - NSTimeInterval(timeInterval)
}

func +=(inout date: NSDate, timeInterval: Int) {
    date = date + timeInterval
}

func -=(inout date: NSDate, timeInterval: Int) {
    date = date - timeInterval
}

func +(date: NSDate, timeInterval: Double) -> NSDate {
    return date.dateByAddingTimeInterval(NSTimeInterval(timeInterval))
}

func -(date: NSDate, timeInterval: Double) -> NSDate {
    return date.dateByAddingTimeInterval(NSTimeInterval(-timeInterval))
}

func +=(inout date: NSDate, timeInterval: Double) {
    date = date + timeInterval
}

func -=(inout date: NSDate, timeInterval: Double) {
    date = date - timeInterval
}

func -(date: NSDate, otherDate: NSDate) -> NSTimeInterval {
    return date.timeIntervalSinceDate(otherDate)
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}

extension NSDate: Comparable {
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}
