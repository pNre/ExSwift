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
        XCTAssertTrue(f()!)
        
        var called = false
        
        let g = ExSwift.after(2, { called = true })
        
        g()
        g()
        g()
        
        XCTAssertTrue(called)
        
    }

    func testOnce () {

        //  Test execution
        var test = false

        let f = Ex.once { test = !test }
        
        f()
        f()
        
        XCTAssertTrue(test)
        
        //  Test return value
        var seq = [1, 2, 3, 4].generate()

        let g = Ex.once { Void -> Int in
            return seq.next()!
        }
        
        XCTAssertEqual(g(), 1)
        XCTAssertEqual(g(), 1)
        
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
        
        XCTAssertEqual(helloWorld(), "Hello World")
    }
    
    func testCached () {
        var calls = 0
        
        // Slow Fibonacci
        var fib: ((Int...) -> Int)!
        fib = { (params: Int...) -> Int in
            let n = params[0]
            
            calls++
            
            if n <= 1 {
                return n
            }
            return fib(n - 1) + fib(n - 2)
        }
        
        let fibonacci = Ex.cached(fib)
        
        // This one is computed (fib is called 465 times)
        fibonacci(12)
        XCTAssertEqual(465, calls)
        
        // The results is taken from the cache (fib is not called)
        fibonacci(12)
        XCTAssertEqual(465, calls)
    }
    
}
