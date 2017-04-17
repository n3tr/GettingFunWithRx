//
//  GettingFunWithRxTests.swift
//  GettingFunWithRxTests
//
//  Created by n3tr on 3/31/2560 BE.
//  Copyright © 2560 Jirat Ki. All rights reserved.
//

import XCTest
import RxTest
@testable import GettingFunWithRx

class GettingFunWithRxTests: XCTestCase {
    
    let scheduler = TestScheduler(initialClock: 0)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let viewModel = ViewModel()
        var observer: TestableObserver<String>
        observer = scheduler.createObserver(String.self)
        _ = viewModel.currentText.subscribe(observer)
        
        XCTAssertEqual(observer.events, [next(0, "0")])
        
        viewModel.increaseTapped()
        XCTAssertEqual(observer.events.last!.value.element!, "1")
        
        viewModel.increaseTapped()
        XCTAssertEqual(observer.events.last!.value.element!, "2")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
