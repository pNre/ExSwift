//
//  ExSwiftTests.swift
//  ExSwift
//
//  Created by pNre on 07/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class ExSwiftSpec: QuickSpec {

    override func spec() {

        it("after") {

            let f = ExSwift.after(2, function: { () -> Bool in return true })

            expect(f()).to(beNil())
            expect(f()).to(beNil())

            expect(f()).to(beTrue())

            var called = false
            let g = ExSwift.after(2, function: { called = true })

            g()

            expect(called).to(beFalse())

            g()

            expect(called).to(beFalse())

            g()

            expect(called).to(beTrue())

        }

        it("once") {

            var seq = [1, 2, 3, 4].generate()

            let g = Ex.once { Void -> Int in
                return seq.next()!
            }

            expect(g()) == 1
            expect(g()) == 1

        }

        it("partial") {

            let add = { (params: Int...) -> Int in
                return params.reduce(0, combine: +)
            }

            let add5 = ExSwift.partial(add, 5)

            expect(add5(10)) == 15
            expect(add5(1, 2)) == 8

        }

        it("bind") {

            let concat = { (params: String...) -> String in
                guard params.count > 0 else {
                    return ""
                }
                
                var result: String = params.first!
                
                for param in params.skip(1) {
                    result += " \(param)"
                }
                
                return result
            }

            let helloWorld = ExSwift.bind(concat, "Hello", "World")

            expect(helloWorld()) == "Hello World"

        }

        it("cached") {

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
            expect(calls) == 465

            // The results is taken from the cache (fib is not called again)
            fibonacci(12)
            expect(calls) == 465

        }

        describe("operators") {

            it("spaceship") {

                expect(4 <=> 5) == -1
                expect(5 <=> 4) == 1
                expect(4 <=> 4) == 0

            }

        }

    }

}
