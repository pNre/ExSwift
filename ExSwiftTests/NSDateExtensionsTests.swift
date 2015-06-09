//
//  NSDateExtensionsTests.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 23/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class NSDateExtensionsSpec: QuickSpec {
    
    let dateFormatter = NSDateFormatter()
    
    var startDate: NSDate?

    override func spec() {
    
        beforeSuite {
            
            self.dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            
        }

        beforeEach {
            
            self.startDate = self.dateFormatter.dateFromString("30/11/1988 00:00:00")

        }
        
        describe("manipulation") {
            
            it("addSeconds") {
                
                var expectedDate = self.dateFormatter.dateFromString("30/11/1988 00:00:42")
                
                expect(self.startDate?.addSeconds(42)) == expectedDate
                expect(self.startDate?.add(seconds: 42)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("29/11/1988 23:59:18")
                
                expect(self.startDate?.addSeconds(-42)) == expectedDate
                expect(self.startDate?.add(seconds: -42)) == expectedDate
                
            }
            
            it("addMinutes") {

                var expectedDate = self.dateFormatter.dateFromString("30/11/1988 00:42:00")
    
                expect(self.startDate?.addMinutes(42)) == expectedDate
                expect(self.startDate?.add(minutes: 42)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("29/11/1988 23:18:00")
                
                expect(self.startDate?.addMinutes(-42)) == expectedDate
                expect(self.startDate?.add(minutes: -42)) == expectedDate
                
            }
            
            it("addHours") {
                
                var expectedDate = self.dateFormatter.dateFromString("01/12/1988 18:00:00")
                
                expect(self.startDate?.addHours(42)) == expectedDate
                expect(self.startDate?.add(hours: 42)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("28/11/1988 06:00:00")
                
                expect(self.startDate?.addHours(-42)) == expectedDate
                expect(self.startDate?.add(hours: -42)) == expectedDate
                
            }
            
            it("addDays") {
                
                var expectedDate = self.dateFormatter.dateFromString("02/12/1988 00:00:00")
                
                expect(self.startDate?.addDays(2)) == expectedDate
                expect(self.startDate?.add(days: 2)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("19/10/1988 00:00:00")
                
                expect(self.startDate?.addDays(-42)) == expectedDate
                expect(self.startDate?.add(days: -42)) == expectedDate
                
            }
            
            it("addWeeks") {
                
                var expectedDate = self.dateFormatter.dateFromString("7/12/1988 00:00:00")
                
                expect(self.startDate?.addWeeks(1)) == expectedDate
                expect(self.startDate?.add(weeks: 1)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("23/11/1988 00:00:00")
                
                expect(self.startDate?.addWeeks(-1)) == expectedDate
                expect(self.startDate?.add(weeks: -1)) == expectedDate
                
            }
            
            it("addMonths") {
                
                var expectedDate = self.dateFormatter.dateFromString("30/12/1988 00:00:00")
                
                expect(self.startDate?.addMonths(1)) == expectedDate
                expect(self.startDate?.add(months: 1)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("30/10/1988 00:00:00")
                
                expect(self.startDate?.addMonths(-1)) == expectedDate
                expect(self.startDate?.add(months: -1)) == expectedDate
                
            }
            
            it("addYears") {
                
                var expectedDate = self.dateFormatter.dateFromString("30/11/1989 00:00:00")
                
                expect(self.startDate?.addYears(1)) == expectedDate
                expect(self.startDate?.add(years: 1)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("30/11/1987 00:00:00")
                
                expect(self.startDate?.addYears(-1)) == expectedDate
                expect(self.startDate?.add(years: -1)) == expectedDate
                
            }
            
            it("add") {
                
                var expectedDate = self.dateFormatter.dateFromString("10/01/1990 18:42:42")

                expect(self.startDate?.add(seconds: 42, minutes: 42, hours: 42, days: 2, weeks: 1 , months: 1, years: 1)) == expectedDate
                
                expectedDate = self.dateFormatter.dateFromString("20/10/1987 22:17:18")
                
                expect(self.startDate?.add(seconds: -42, minutes: -42, hours: -1, days: -2, weeks: -1 , months: -1, years: -1)) == expectedDate

            }
            
        }
        
        describe("comparison") {
            
            it("isAfter") {
                
                let date = NSDate()
                
                let futureDate = date.addSeconds(42)
                let pastDate = date.addSeconds(-42)
                
                expect(futureDate.isAfter(date)).to(beTrue())
                expect(date.isAfter(date)).to(beFalse())
                expect(pastDate.isAfter(date)).to(beFalse())

            }
            
            it("isBefore") {
                
                let date = NSDate()
                
                let futureDate = date.addSeconds(42)
                let pastDate = date.addSeconds(-42)
                
                expect(futureDate.isBefore(date)).to(beFalse())
                expect(date.isBefore(date)).to(beFalse())
                expect(pastDate.isBefore(date)).to(beTrue())
                
            }
            
        }
        
        it("components properties") {
            
            expect(self.startDate!.year) == 1988
            expect(self.startDate!.month) == 11
            expect(self.startDate!.days) == 30
            expect(self.startDate!.hours) == 0
            expect(self.startDate!.minutes) == 0
            expect(self.startDate!.seconds) == 0
            expect(self.startDate!.weekday) == 4
            expect(self.startDate!.weekMonth) == 5

        }
        
        describe("comparable") {
        
            it("sorting") {
                
                let firstDate = self.startDate!.addSeconds(0)
                let secondDate = self.startDate!.addSeconds(42)
                let thirdDate = self.startDate!.addSeconds(-42)
                let fourthDate = self.startDate!.addSeconds(-84)
                let fifthDate = self.startDate!.addSeconds(84)
                
                var dates = [thirdDate, secondDate, firstDate, fourthDate, fifthDate]
                
                let expected = [fifthDate, secondDate, firstDate, thirdDate, fourthDate]
                let expectedReverded = expected.reverse()
                
                for _ in 0 ... 42 {
                    dates.shuffle()
                    
                    dates.sortInPlace( { $0 > $1 } )
                    expect(dates) == expected
                    
                    dates.sortInPlace( { $0 < $1 } )
                    expect(dates) == Array(expectedReverded)
                }
                
            }
            
            it("comparable") {
                
                let date = self.startDate!.addSeconds(-42)
                let anotherDate = self.startDate!.addSeconds(42)
                let shouldBeTheSameDate = NSDate(timeInterval: 0, sinceDate: self.startDate!)
                
                expect(self.startDate) == shouldBeTheSameDate
                
                expect(self.startDate) > date
                expect(self.startDate) >= date

                expect(self.startDate) <= anotherDate
                expect(self.startDate) < anotherDate

                expect(date) != self.startDate
                expect(anotherDate) != self.startDate

            }
            
        }
        
        it("arithmetic") {
            
            let date = NSDate() as NSDate
            
            expect(date.timeIntervalSinceDate(date - 1.hour)) == 1.hour
            expect(date.timeIntervalSinceDate(date + 1.hour)) == -1.hour
            
            var otherDate = date
            
            otherDate -= 1.minute
            expect(otherDate) !== date
            expect(date.timeIntervalSinceDate(otherDate)) == 1.minute
            
            otherDate += 1.hour
            expect(date.timeIntervalSinceDate(otherDate)) == 1.minute - 1.hour
            
        }
    
    }

}

