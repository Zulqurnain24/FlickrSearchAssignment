//
//  FlickrSearchAssignment_FlickrTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_FlickrTest: XCTestCase {
    let timeInterval = 10
    var sut: Flickr!
    
    override func setUp() {
        sut = Flickr()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSearchFlickrDataBaseForTerm() {
          //Test Flickr Database Search logic
         let expectation = self.expectation(description: "Search Flickr Database for the term")

        sut.searchFlickrDataBaseForTerm("Cherry", completion: {results, paging, error in
            XCTAssertNotNil(results, "non nil results test")
            XCTAssertNil(error, "nil error test")
            expectation.fulfill()
        })
           
        waitForExpectations(timeout: TimeInterval(timeInterval), handler: nil)
    }

}
