//
//  WarpKitTests.swift
//  WarpKitTests
//
//  Created by Adam Nemecek on 12/3/16.
//
//

import XCTest
import WarpKit

class WarpKitTests: XCTestCase {
    
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
        // Use XCTAssert and related functions to verify your tests produce the correct results.

//        let s = Array(0...10).shuffle()
        let s: SortedArray = [2,1,34]
        XCTAssert(s == [1,2,34])


    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
