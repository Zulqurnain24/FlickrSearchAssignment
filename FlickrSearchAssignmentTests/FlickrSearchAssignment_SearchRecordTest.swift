//
//  FlickrSearchAssignment_SearchRecordTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_SearchRecordTest: XCTestCase {
    var sut: SearchRecord!
    override func setUp() {
        sut = SearchRecord(string: "Cherry", time: "\(Date())")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSearchRecord() {
         //Test SearchRecord equality logic
        XCTAssertEqual(sut, SearchRecord(string: "Cherry", time: "\(Date())"), "SearchRecord element equality test")
    }
}
