//
//  FlickrSearchAssignment_MZOperationTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_MZOperationTest: XCTestCase {
    var sut: MZOperation!
    let timeInterval = 4
    override func setUp() {
        sut = MZOperation(url: URL(string: "https://combo.staticflickr.com/ap/build/images/refencing-announcement/bird2.jpg")!, indexPath: IndexPath(item: 0, section: 0))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMZOperationDownloadImageFromUrl() {
        //Test MZOperation download image logic
        let expectation = self.expectation(description: "Download Image")
        sut.downloadImageFromUrl({ image in
            XCTAssertEqual(image.jpegData(compressionQuality: 0), UIImage(imageLiteralResourceName: "bird2.jpg").jpegData(compressionQuality: 0), "image equality test")
             expectation.fulfill()
        })
        waitForExpectations(timeout: TimeInterval(timeInterval), handler: nil)
    }

}
