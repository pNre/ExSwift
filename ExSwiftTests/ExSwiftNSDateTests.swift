//
//  ExSfitNSDateTests.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 23/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//


import XCTest

class ExSwiftNSDataTests: XCTestCase {
    
    let dateFormatter = NSDateFormatter()
    var startDate: NSDate?
    
    override func setUp() {
        super.setUp()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        startDate = dateFormatter.dateFromString("30/11/1988 00:00:00")
    }
    
    // MARK:  NSDate Manipulation

    func testAddSeconds() {
        var expectedDate = dateFormatter.dateFromString("30/11/1988 00:00:42")
        var result = startDate?.addSeconds(42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(seconds:42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("29/11/1988 23:59:18")
        result = startDate?.addSeconds(-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(seconds:-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
    }
    
    func testAddMinutes() {
        var expectedDate = dateFormatter.dateFromString("30/11/1988 00:42:00")
        var result = startDate?.addMinutes(42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(minutes:42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("29/11/1988 23:18:00")
        result = startDate?.addMinutes(-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(minutes:-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
    }
    
    func testAddHours() {
        var expectedDate = dateFormatter.dateFromString("01/12/1988 18:00:00")
        var result = startDate?.addHours(42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(hours:42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("28/11/1988 06:00:00")
        result = startDate?.addHours(-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(hours:-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        
    }
    
    func testAddDays() {
        var expectedDate = dateFormatter.dateFromString("02/12/1988 00:00:00")
        var result = startDate?.addDays(2)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(days:2)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("19/10/1988 00:00:00")
        result = startDate?.addDays(-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(days:-42)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
    }
    
    func testAddWeeks() {
        var expectedDate = dateFormatter.dateFromString("7/12/1988 00:00:00")
        var result = startDate?.addWeeks(1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(weeks:1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("23/11/1988 00:00:00")
        result = startDate?.addWeeks(-1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(weeks:-1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
    }
    
    func testAddMonths() {
        var expectedDate = dateFormatter.dateFromString("30/12/1988 00:00:00")
        var result = startDate?.addMonths(1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(months:1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("30/10/1988 00:00:00")
        result = startDate?.addMonths(-1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(months:-1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
    }
    
    func testAddYears() {
        var expectedDate = dateFormatter.dateFromString("30/11/1989 00:00:00")
        var result = startDate?.addYears(1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(years:1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("30/11/1987 00:00:00")
        result = startDate?.addYears(-1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        result = startDate?.add(years:-1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
    }
    
    func testAdd(){
        var expectedDate = dateFormatter.dateFromString("10/01/1990 18:42:42")
        var result = startDate?.addMonths(1)
        result = startDate?.add(seconds: 42, minutes: 42, hours: 42, days: 2, weeks: 1 , months: 1, years: 1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")
        
        expectedDate = dateFormatter.dateFromString("20/10/1987 22:17:18")
        result = startDate?.add(seconds: -42, minutes: -42, hours: -1, days: -2, weeks: -1 , months: -1, years: -1)
        XCTAssertEqual(expectedDate!, result!, "Date mismatch")

    }
    
    // MARK:  Date comparison
    
    func testIsAfter(){
        var date = NSDate()
        var futureDate = date.addSeconds(42)
        var pastDate = date.addSeconds(-42)
        XCTAssertTrue(futureDate.isAfter(date), "Future date should be in the future")
        XCTAssertFalse(date.isAfter(date), "Past date should be in the past")
        XCTAssertFalse(pastDate.isAfter(date), "Past date should be in the past")
    }

    func testIsBefore(){
        var date = NSDate()
        var futureDate = date.addSeconds(42)
        var pastDate = date.addSeconds(-42)
        XCTAssertFalse(futureDate.isBefore(date), "Future date should be in the future")
        XCTAssertTrue(pastDate.isBefore(date), "Past date should be in the past")
        XCTAssertFalse(date.isAfter(date), "Past date should be in the past")
        
    }
    
    // MARK:  Getter
    
    func testGetter() {
        XCTAssertEqual(1988, startDate!.year, "Year Mismatch")
        XCTAssertEqual(11, startDate!.month, "Month Mismatch")
        XCTAssertEqual(30, startDate!.days, "Day Mismatch")
        XCTAssertEqual(0, startDate!.hours, "Hours Mismatch")
        XCTAssertEqual(0, startDate!.minutes, "Minutes Mismatch")
        XCTAssertEqual(0, startDate!.seconds, "Seconds Mismatch")
        XCTAssertEqual(4, startDate!.weekday, "Weekmonth Mismatch")
        XCTAssertEqual(5, startDate!.weekMonth, "Weekmonth Mismatch")
    }
    
    // MARK: Comparable
    
    func testSorting () {
        var firstDate = startDate!.addSeconds(0)
        var secondDate = startDate!.addSeconds(42)
        var thirdDate = startDate!.addSeconds(-42)
        var fourthDate = startDate!.addSeconds(-84)
        var fifthDate = startDate!.addSeconds(84)
        
        var dates : [NSDate] = [thirdDate, secondDate, firstDate, fourthDate, fifthDate]
        
        let expected : [NSDate] = [fifthDate, secondDate, firstDate, thirdDate, fourthDate]

        let expectedReverded = expected.reverse()
        
        for i in 0 ... 42 {
            dates.shuffle()
        
            dates.sort( { $0 > $1 } )
            XCTAssertEqual(expected, dates, "Sort mismatch")
        
            dates.sort( { $0 < $1 } )
            XCTAssertEqual(expectedReverded, dates, "Sort mismatch")
        }
    }
    
    func testComparable(){
        var date = startDate!.addSeconds(-42)
        var anotherDate = startDate!.addSeconds(42)
        let shouldBeTheSameDate = NSDate(timeInterval: 0, sinceDate: startDate!)


        XCTAssertTrue(startDate > date, "Date should be greater")
        XCTAssertFalse(startDate > anotherDate, "Date shouldn't be greater")
        XCTAssertFalse(startDate > shouldBeTheSameDate, "Date shouldn't be greater")
        
        XCTAssertTrue(startDate < anotherDate, "Date should be lower")
        XCTAssertFalse(startDate < date, "Date shouldn't be lower")
        XCTAssertFalse(startDate < shouldBeTheSameDate, "Date shouldn't be lower")

        XCTAssertTrue(startDate >= shouldBeTheSameDate, "Date should be greater or equal")
        XCTAssertTrue(startDate >= date, "Date should be greater or equal")
        XCTAssertFalse(startDate >= anotherDate, "Date shouldn't be greater or equal")
        
        XCTAssertTrue(startDate <= shouldBeTheSameDate, "Date should be lower or equal")
        XCTAssertTrue(startDate < anotherDate, "Date should be lower")
        XCTAssertFalse(startDate <= date, "Date shouldn't be greater or equal")
        
        XCTAssertFalse(date == startDate, "Date should mismatch")
        XCTAssertFalse(anotherDate == startDate, "Date should mismatch")
        XCTAssertTrue(shouldBeTheSameDate == startDate, "Date shouldn't mismatch")
    }
}
