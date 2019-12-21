//
//  FlickrSearchAssignment_ImageDownloadManagerTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_ImageDownloadManagerTest: XCTestCase {
    var sut: ImageDownloadManager!
    let timeInterval = 4
    override func setUp() {
        sut = ImageDownloadManager.shared
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testImageDownloadManager() {
        //Test ImageDownloadManager Download FlickrImage logic
        let expectation = self.expectation(description: "Download FlickrImage")
        sut.downloadImage(FlickrImage(photoID: "49245937158", farm: 66, server: "65535", secret: "d91eb1f965"), indexPath: IndexPath(row: 0, section: 0)) { (image, url, indexPath, error) in
            XCTAssertNotNil(image, "image not nil test")
            XCTAssertNotNil(url, "url not nil test")
            XCTAssertNotNil(indexPath, "indexPath not nil test")
            XCTAssertNil(error, "error nil test")
            expectation.fulfill()
        }
        waitForExpectations(timeout: TimeInterval(timeInterval), handler: nil)
    }
}
