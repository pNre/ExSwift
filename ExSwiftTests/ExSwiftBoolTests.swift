//
//  ExSwiftBoolTests.swift
//  ExSwift
//
//  Created by Hernandez Alvarez, David on 2/10/15.
//  Copyright (c) 2015 pNre. All rights reserved.
//

import XCTest

class ExSwiftBoolTests: XCTestCase {
  
  func testToogleTrue() {
    var bool: Bool = false
    XCTAssertTrue(bool.toggle(), "Bool did not toogle to true")
  }
  
  func testToogleFalse() {
    var bool: Bool = true
    XCTAssertFalse(bool.toggle(), "Bool did not toogle to false")
  }
  
}