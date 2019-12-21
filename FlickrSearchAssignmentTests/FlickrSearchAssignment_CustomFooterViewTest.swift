//
//  FlickrSearchAssignment_CustomFooterViewTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_CustomFooterViewTest: XCTestCase {
    var sut: CustomFooterView!
    override func setUp() {
        sut = CustomFooterView()
    }

    override func tearDown() {
          
      sut = nil
      
      super.tearDown()
    }

    func testCustomFooterView() {
        //Test CustomFooterView display logic
        sut.awakeFromNib()
        
        //Test CustomFooterView animation logic
        sut.prepareInitialAnimation()
        XCTAssertEqual(sut.isAnimatingFinal, false)
        sut.startAnimate()
        XCTAssertEqual(sut.isAnimatingFinal, true, "isAnimatingFinal true test")
        sut.stopAnimate()
        XCTAssertEqual(sut.isAnimatingFinal, false, "isAnimatingFinal false test")
        sut.animateFinal()
        XCTAssertEqual(sut.isAnimatingFinal, true, "animateFinal test")
    }
}
