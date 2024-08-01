//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by KSH on 7/22/24.
//

import XCTest

final class TipCalculatorUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₩0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₩0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₩0")
    }
}
