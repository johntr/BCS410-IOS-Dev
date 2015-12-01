//
//  FinalProjectTests.swift
//  FinalProjectTests
//
//  Created by John Redlich on 10/30/15.
//  Copyright (c) 2015 John Redlich. All rights reserved.
//

import UIKit
import XCTest

class FinalProjectTests: XCTestCase {
    
    var Dealers : DealerLoader?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    //test to see if there are any dealers loaded at a location we know there are dealers.
    func testDealerLoad() {
        self.Dealers = DealerLoader(url:"http://app-adc.gotpantheon.com/api/v1/dealers/11788")
        
        XCTAssert(Dealers?.Dealers.count > 0, "Pass")
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
            self.Dealers = DealerLoader(url:"http://app-adc.gotpantheon.com/api/v1/dealers/11788")
        }
    }
    
}
