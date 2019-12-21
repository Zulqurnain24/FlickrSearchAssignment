//
//  FlickrSearchAssignment_UICollectionViewCell_Addition.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/20/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_UICollectionViewCell_Addition: XCTestCase {

    func testUICollectionViewCell() {
        //Test UICollectionViewCell extension identifier logic
        XCTAssertEqual( FlickrPhotoCell.identifier, "FlickrPhotoCell", "FlickrPhotoCell identifier value check test")
    }
}
