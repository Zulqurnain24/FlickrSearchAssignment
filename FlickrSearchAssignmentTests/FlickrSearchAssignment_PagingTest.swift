//
//  FlickrSearchAssignment_PagingTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_PagingTest: XCTestCase {

    var sut: Paging!
    
    override func setUp() {
        sut = Paging(totalPages: 10, elements: 5, currentPage: 1)
    }

    override func tearDown() {
             
         sut = nil
         
         super.tearDown()
    }

    func testPaging() {
        //Test testPaging totalPages logic
        XCTAssertEqual(sut.totalPages, 10, "totalPages equality test")
         //Test testPaging numberOfElements logic
        XCTAssertEqual(sut.numberOfElements, 5, "numberOfElements equality test")
         //Test testPaging currentPage logic
        XCTAssertEqual(sut.currentPage, 1, "currentPage equality test")
    }

}
