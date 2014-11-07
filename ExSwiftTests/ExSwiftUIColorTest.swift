//
//  PKColorTest.swift
//  PKLibrary
//
//  Created by Piergiuseppe Longo on 09/10/14.
//  Copyright (c) 2014 Piergiuseppe Longo. All rights reserved.
//

import UIKit
import XCTest

class ExSwiftUIColorTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testColorFromHexStrings() {
        
        XCTAssertEqual(UIColor.redColor(), UIColor(hexString: "#FF0000"), "Color mistmatch");
        XCTAssertEqual(UIColor.blueColor(), UIColor(hexString: "#0000FF"), "Color mistmatch");
        XCTAssertEqual(UIColor.greenColor(), UIColor(hexString: "#00FF00"), "Color mistmatch");
        XCTAssertEqual(UIColor(red: 186/255, green: 85/255, blue: 211/255, alpha: 1), UIColor(hexString: "#BA55D3"), "Color mistmatch");
    }
        
    func testRandomColor() {
        var oldColor = UIColor.randomColor();
        for i in 0..<10 {
            var newColor = UIColor.randomColor();
            XCTAssertNotEqual(oldColor, UIColor.randomColor(), "Color should mistmatch");
            oldColor = newColor;
        }
    }
    
    func testFlatColor() {
        var black = UIColor.blackColor();
        for flatColor in flatColors {
            XCTAssertNotEqual(black, UIColor(hexString: flatColor), "Color should mistmatch");
        }
    }
    
        
    
    


}
