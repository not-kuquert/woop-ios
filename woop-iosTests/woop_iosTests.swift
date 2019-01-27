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
    
    var event: Event!
    
    override func setUp() {
        let promisse = expectation(description: "Wait to load resource from json")
        
        EventsFacade.sharedLocal.event(id: "1") { (event, error) in
            self.event = event
            promisse.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    override func tearDown() {}
    
    func testDateFormat() {
        let dateView = DateView()
        let formatter = DateFormatter(dateFormat: "dd/MM/yyyy")
        dateView.date = formatter.date(from: "05/03/1995")
        
        XCTAssertEqual(dateView.dayLabel.text, "05")
        XCTAssertEqual(dateView.monthLabel.text, "MAR")
        XCTAssertEqual(dateView.yearLabel.text, "1995")
    }
    
    func testDateParsingStrategy() {
        XCTAssertEqual(event.date, Date(timeIntervalSince1970: 1534784400000 / 1000 ))
    }
    
    func testHttpsTranslation() {
        XCTAssertTrue(event.image.hasPrefix("http://"))
        XCTAssertEqual(event.imageUrl.scheme, "https")
        
        XCTAssertTrue(event.people.first?.picture.hasPrefix("http://") ?? false)
        XCTAssertEqual(event.people.first?.pictureUrl.scheme, "https")
    }
    
    func testPriceFormatter() {
        let eventView = EventView()
        eventView.event = event
        XCTAssertEqual(eventView.priceLabel.text, "R$ 29,99")
        
        var newEvent = event
        newEvent?.price = 100.0
        eventView.event = newEvent
        XCTAssertEqual(eventView.priceLabel.text, "R$ 100,00")
        
        var newEvent2 = event
        newEvent2?.price = 10.05
        eventView.event = newEvent2
        XCTAssertEqual(eventView.priceLabel.text, "R$ 10,05")
        
        var newEvent3 = event
        newEvent3?.price = 0
        eventView.event = newEvent3
        XCTAssertEqual(eventView.priceLabel.text, "GRÁTIS")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
