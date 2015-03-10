//
//  ExSwiftNSNumberFormatterTests.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 07/03/15.
//  Copyright (c) 2015 pNre. All rights reserved.
//

import UIKit
import XCTest

class ExSwiftNSNumberFormatterTests: XCTestCase {
    
    var numberFormatter = NSNumberFormatter()
    
    override func setUp() {
        super.setUp()
        numberFormatter = NSNumberFormatter()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSetPrecision() {
        let number = 42.42
        self.numberFormatter.setPrecision(3);
        
        XCTAssertEqual("42.420", self.numberFormatter.stringFromNumber(number)!)
        self.numberFormatter.setPrecision(1);
        XCTAssertEqual("42.4", self.numberFormatter.stringFromNumber(number)!)

        self.numberFormatter.setPrecision(-1);
        XCTAssertEqual("42", self.numberFormatter.stringFromNumber(number)!)
        self.numberFormatter.setPrecision(0);
        XCTAssertEqual("42", self.numberFormatter.stringFromNumber(number)!)
    }
    
}
