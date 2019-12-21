//
//  FlickrSearchAssignment_FlickrImageTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_FlickrImageTest: XCTestCase {
    var sut: FlickrImage!
    
    override func setUp() {
        sut = FlickrImage(photoID: "101", farm: 5, server: "Farm4", secret: "123")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFlickrImage() {
        //Test FlickrImage photoID logic
        XCTAssertEqual(sut?.photoID, "101", "photoID equality test")
        //Test FlickrImage farm logic
        XCTAssertEqual(sut?.farm, 5, "farm equality test")
        //Test FlickrImage farm server
        XCTAssertEqual(sut?.server, "Farm4", "server equality test")
        //Test FlickrImage farm secret
        XCTAssertEqual(sut?.secret, "123", "secret equality test")
    }

}
