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
    
        :param: seconds number of seconds to add
        :param: minutes number of minutes to add
        :param: hours number of hours to add
        :param: days number of days to add
        :param: weeks number of weeks to add
        :param: months number of months to add
        :param: years number of years to add
        :returns: the NSDate computed
    */
   public func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> NSDate {
        var calendar = NSCalendar.currentCalendar()
    
        let version = floor(NSFoundationVersionNumber)
    
        if version <= NSFoundationVersionNumber10_9_2 {
            var component = NSDateComponents()
            component.setValue(seconds, forComponent: .CalendarUnitSecond)
            
            var date : NSDate! = calendar.dateByAddingComponents(component, toDate: self, options: nil)!
            component = NSDateComponents()
            component.setValue(minutes, forComponent: .CalendarUnitMinute)
            date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
            
            component = NSDateComponents()
            component.setValue(hours, forComponent: .CalendarUnitHour)
            date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
            
            component = NSDateComponents()
            component.setValue(days, forComponent: .CalendarUnitDay)
            date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
            
            component = NSDateComponents()
            component.setValue(weeks, forComponent: .CalendarUnitWeekOfMonth)
            date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
            
            component = NSDateComponents()
            component.setValue(months, forComponent: .CalendarUnitMonth)
            date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
            
            component = NSDateComponents()
            component.setValue(years, forComponent: .CalendarUnitYear)
            date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
            return date
        }
        
        var date : NSDate! = calendar.dateByAddingUnit(.CalendarUnitSecond, value: seconds, toDate: self, options: nil)
        date = calendar.dateByAddingUnit(.CalendarUnitMinute, value: minutes, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(.CalendarUnitDay, value: days, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(.CalendarUnitHour, value: hours, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(.CalendarUnitWeekOfMonth, value: weeks, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(.CalendarUnitMonth, value: months, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(.CalendarUnitYear, value: years, toDate: date, options: nil)
        return date
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
    
        :param: seconds number of seconds to add
        :returns: the NSDate computed
    */
    public func addSeconds (seconds: Int) -> NSDate {
        return add(seconds: seconds)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
    
        :param: minutes number of minutes to add
        :returns: the NSDate computed
    */
    public func addMinutes (minutes: Int) -> NSDate {
        return add(minutes: minutes)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
    
        :param: hours number of hours to add
        :returns: the NSDate computed
    */
    public func addHours(hours: Int) -> NSDate {
        return add(hours: hours)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of days to self date
    
        :param: days number of days to add
        :returns: the NSDate computed
    */
    public func addDays(days: Int) -> NSDate {
        return add(days: days)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
    
        :param: weeks number of weeks to add
        :returns: the NSDate computed
    */
    public func addWeeks(weeks: Int) -> NSDate {
        return add(weeks: weeks)
    }
    
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of months to self date
    
        :param: months number of months to add
        :returns: the NSDate computed
    */
    
    public func addMonths(months: Int) -> NSDate {
        return add(months: months)
    }
    
    /**
        Returns a new NSDate object representing the date calculated by adding an amount of years to self date
    
        :param: years number of year to add
        :returns: the NSDate computed
    */
    public func addYears(years: Int) -> NSDate {
        return add(years: years)
    }
    
    // MARK:  Date comparison
    
    /**
        Checks if self is after input NSDate
    
        :param: date NSDate to compare
        :returns: True if self is after the input NSDate, false otherwise
    */
    public func isAfter(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedDescending)
    }
    
    /**
        Checks if self is before input NSDate
    
        :param: date NSDate to compare
        :returns: True if self is before the input NSDate, false otherwise
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
            return getComponent(.CalendarUnitYear)
        }
    }

    /**
        Date month
    */
    public var month : Int {
        get {
            return getComponent(.CalendarUnitMonth)
        }
    }
    
    /**
        Date weekday
    */
    public var weekday : Int {
        get {
            return getComponent(.CalendarUnitWeekday)
        }
    }

    /**
        Date weekMonth
    */
    public var weekMonth : Int {
        get {
            return getComponent(.CalendarUnitWeekOfMonth)
        }
    }

    
    /**
        Date days
    */
    public var days : Int {
        get {
            return getComponent(.CalendarUnitDay)
        }
    }
    
    /**
        Date hours
    */
    public var hours : Int {
        
        get {
            return getComponent(.CalendarUnitHour)
        }
    }
    
    /**
        Date minuts
    */
    public var minutes : Int {
        get {
            return getComponent(.CalendarUnitMinute)
        }
    }
    
    /**
        Date seconds
    */
    public var seconds : Int {
        get {
            return getComponent(.CalendarUnitSecond)
        }
    }
    
    /**
        Returns the value of the NSDate component
    
        :param: component NSCalendarUnit
        :returns: the value of the component
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
        return self.dynamicType(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate + n)
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

extension NSDate: Equatable {
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}

extension NSDate: Comparable {
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}
