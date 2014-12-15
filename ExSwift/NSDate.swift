//
//  File.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 23/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension NSDate{
    
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
    public func add(seconds:Int=0, minutes:Int = 0, hours:Int = 0, days:Int = 0, weeks:Int = 0, months:Int = 0, years:Int = 0) -> NSDate {
        var calendar = NSCalendar.currentCalendar()
        var date = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitSecond, value: seconds, toDate: self, options: nil) as NSDate!
        date = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitMinute, value: minutes, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: days, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitHour, value: hours, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitWeekOfMonth, value: weeks, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitMonth, value: months, toDate: date, options: nil)
        date = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitYear, value: years, toDate: date, options: nil)
        return date
    }
    
    /**
    Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
    
    :param: seconds number of seconds to add
    :returns: the NSDate computed
    */
    public func addSeconds (seconds:Int) -> NSDate {
        return add(seconds: seconds)
    }
    
    /**
    Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
    
    :param: minutes number of minutes to add
    :returns: the NSDate computed
    */
    public func addMinutes (minute:Int) -> NSDate {
        return add(minutes: minute)
    }
    
    /**
    Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
    
    :param: hours number of hours to add
    :returns: the NSDate computed
    */
    public func addHours(hours:Int) -> NSDate {
        return add(hours: hours)
    }
    
    /**
    Returns a new NSDate object representing the date calculated by adding an amount of days to self date
    
    :param: days number of days to add
    :returns: the NSDate computed
    */
    public func addDays(days:Int) -> NSDate {
        return add(days: days)
    }
    
    /**
    Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
    
    :param: weeks number of weeks to add
    :returns: the NSDate computed
    */
    public func addWeeks(weeks:Int) -> NSDate {
        return add(weeks: weeks)
    }
    
    
    /**
    Returns a new NSDate object representing the date calculated by adding an amount of months to self date
    
    :param: months number of months to add
    :returns: the NSDate computed
    */
    
    public func addMonths(months:Int) -> NSDate {
        return add(months: months)
    }
    
    /**
    Returns a new NSDate object representing the date calculated by adding an amount of years to self date
    
    :param: years number of year to add
    :returns: the NSDate computed
    */
    public func addYears(years:Int) -> NSDate {
        return add(years:years)
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
    
    
}
