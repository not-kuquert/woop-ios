//
//  woop_iosUITests.swift
//  woop-iosUITests
//
//  Created by Marcus Vinicius Kuquert on 1/23/19.
//  Copyright © 2019 kuquert. All rights reserved.
//

import XCTest

class woop_iosUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testA() {
        XCUIApplication().scrollViews.otherElements.buttons["Check-in"].tap()
        
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.tables.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).tap()
        app.scrollViews.otherElements.buttons["Check-in"].tap()
        
        app.keyboards.keys["m"].tap()
        app.keyboards.keys["space"].tap()
        app.keyboards.keys["k"].tap()
        
        app.buttons["Return"].tap()
        
        app.keys["m"].tap()
        app.keys["@"].tap()
        app.keys["k"].tap()
        app.keys["."].tap()
        app.keys["c"].tap()
        
        app.alerts["Precisamos de algumas informanções"].buttons["CHECK-IN"].tap()
        app.alerts["Deu tudo certo, te esperamos no evento"].buttons["Ok"].tap()
        
    }
    
}
