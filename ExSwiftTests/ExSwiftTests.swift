//
//  ExSwiftTests.swift
//  ExSwift
//
//  Created by pNre on 07/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftTests: XCTestCase {

    func testAfter () {
        
        let f = ExSwift.after(2, { () -> Bool in return true })
        
        XCTAssertNil(f())
        XCTAssertNil(f())
        XCTAssertTrue(f())
        
        var called = false
        
        let g = ExSwift.after(2, { called = true })
        
        g()
        g()
        g()
        
        XCTAssertTrue(called)
        
    }

    func testOnce () {

        var test = false

        let f = ExSwift.once { test = !test }
        
        f()
        f()
        
        XCTAssertTrue(test)

    }

    func testPartial () {
        let add = {
            (params: Int...) -> Int in
            return params.reduce(0, { return $0 + $1 })
        }
        let add5 = ExSwift.partial(add, 5)

        XCTAssertEqual(15, add5(10))
        XCTAssertEqual(8, add5(1, 2))
    }

    func testBind () {
        let concat = {
            (params: String...) -> String in
            return params.implode(" ")!
        }
        
        let helloWorld = ExSwift.bind(concat, "Hello", "World")
        
        XCTAssert(helloWorld() == "Hello World")
    }
    
}
