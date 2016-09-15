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
            (component as NSDateComponents).setValue(seconds, forComponent: .second)
            
            var date : Date! = (calendar as NSCalendar).date(byAdding: component, to: self, options: [])!
            component = DateComponents()
            (component as NSDateComponents).setValue(minutes, forComponent: .minute)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(hours, forComponent: .hour)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(days, forComponent: .day)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(weeks, forComponent: .weekOfMonth)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(months, forComponent: .month)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            
            component = DateComponents()
            (component as NSDateComponents).setValue(years, forComponent: .year)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            return date
        }
    
        let options = NSCalendar.Options(rawValue: 0)
        var date : Date! = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.second, value: seconds, to: self, options: options)
        date = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.minute, value: minutes, to: date, options: options)
        date = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: days, to: date, options: options)
        date = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.hour, value: hours, to: date, options: options)
        date = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.weekOfMonth, value: weeks, to: date, options: options)
        date = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.month, value: months, to: date, options: options)
        date = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.year, value: years, to: date, options: options)
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

    public func getComponent (_ component : NSCalendar.Unit) -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(component, from: self)

        return components.value(for: component)
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

func +(date: Date, timeInterval: Int) -> Date {
    return date + TimeInterval(timeInterval)
}

func -(date: Date, timeInterval: Int) -> Date {
    return date - TimeInterval(timeInterval)
}

func +=(date: inout Date, timeInterval: Int) {
    date = date + timeInterval
}

func -=(date: inout Date, timeInterval: Int) {
    date = date - timeInterval
}

func +(date: Date, timeInterval: Double) -> Date {
    return date.addingTimeInterval(TimeInterval(timeInterval))
}

func -(date: Date, timeInterval: Double) -> Date {
    return date.addingTimeInterval(TimeInterval(-timeInterval))
}

func +=(date: inout Date, timeInterval: Double) {
    date = date + timeInterval
}

func -=(date: inout Date, timeInterval: Double) {
    date = date - timeInterval
}

func -(date: Date, otherDate: Date) -> TimeInterval {
    return date.timeIntervalSince(otherDate)
}

public func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == ComparisonResult.orderedSame
}

extension Date: Comparable {
}

public func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == ComparisonResult.orderedAscending
}
