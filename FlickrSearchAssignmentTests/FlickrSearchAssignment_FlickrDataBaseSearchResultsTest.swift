//
//  FlickrSearchAssignment_FlickrDataBaseSearchResultsTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_FlickrDataBaseSearchResultsTest: XCTestCase {

    var sut: FlickrDatabaseSearchResults!
    
    override func setUp() {
        sut = FlickrDatabaseSearchResults()
        sut.searchResults.append(FlickrImage(photoID: "101", farm: 5, server: "Farm4", secret: "123"))
        sut.searchResults.append(FlickrImage(photoID: "123", farm: 3, server: "Farm2", secret: "420"))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFlickrDatabaseSearchResults() {
        //Test FlickrDatabaseSearchResults searchResults first element logic
        XCTAssertEqual(sut.searchResults.first, FlickrImage(photoID: "101", farm: 5, server: "Farm4", secret: "123"), "searchResults first element equality test")
         //Test FlickrDatabaseSearchResults searchResults last element logic
        XCTAssertEqual(sut.searchResults.last, FlickrImage(photoID: "123", farm: 3, server: "Farm2", secret: "420"), "searchResults last element equality test")
    }
}
