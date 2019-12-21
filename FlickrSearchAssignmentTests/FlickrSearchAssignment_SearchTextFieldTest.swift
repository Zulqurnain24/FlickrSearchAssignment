//
//  FlickrSearchAssignment_SearchTextFieldTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_SearchTextFieldTest: XCTestCase {

    var sut: SearchTextField!
    
    override func setUp() {
       sut = SearchTextField()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testSearchTextField() {
        //Test SearchTextField display logic
        sut.awakeFromNib()
        
        //Test SearchTextField animation logic
        sut.startAnimating ()
        XCTAssertEqual(sut.activityIndicator.isAnimating, true, "isAnimating true test")
         sut.stopAnimating()
        XCTAssertEqual(sut.activityIndicator.isAnimating, false, "isAnimating false test")
    }
    
}
