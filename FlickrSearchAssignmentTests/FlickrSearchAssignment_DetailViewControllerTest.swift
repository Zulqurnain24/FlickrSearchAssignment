//
//  FlickrSearchAssignment_DetailViewController.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_DetailViewController: XCTestCase {
    var sut: DetailViewController!
    let timeInterval1 = 5
    override func setUp() {
         sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDetailViewController() {
        //Test detailview display logic
        sut.loadView()
        sut.viewDidLoad()
        sut.viewDidAppear(false)
        sut.imageView.image = UIImage(named: "bird2.jpg")
        
        //Test detailview notification logic
        var notification = Notification(name: Notification.Name(rawValue: "TestNotification"))
        notification.object = FlickrImage(photoID: "49245937158", farm: 66, server: "65535", secret: "d91eb1f965")
        sut.loadImage(notification)
        XCTAssertNotNil(sut.imageView.image, "loadImage Test")
        
        //Test detailview scrollView logic
        XCTAssertNotNil(sut.viewForZooming(in: sut.scrollView), "viewForZooming Test")
    
    }

}
