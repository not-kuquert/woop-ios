//
//  woop_iosTests.swift
//  woop-iosTests
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

@testable import woop_ios
import XCTest

class woop_iosTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDateFormat() {
        let dateView = DateView()
        let formatter = DateFormatter(dateFormat: "dd/MM/yyyy")
        dateView.date = formatter.date(from: "05/03/1995")
        
        XCTAssertEqual(dateView.dayLabel.text, "05")
        XCTAssertEqual(dateView.monthLabel.text, "MAR")
        XCTAssertEqual(dateView.yearLabel.text, "1995")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
