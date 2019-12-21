//
//  FlickrSearchAssignment_SplashScreenViewController.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_SplashScreenViewController: XCTestCase {
 
    var sut: SplashScreenViewController!
    let timeInterval = 10.0
    
    override func setUp() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testSplashScreenViewController() {
        //Test splash view display logic
        sut.loadView()
        sut.viewDidLoad()
        sut.viewDidAppear(false)
        //Test splash view animation logic
        let expectation = self.expectation(description: "Segue After Animation")
        sut.setupViews({
            expectation.fulfill()
        })
        waitForExpectations(timeout: timeInterval, handler: nil)
        XCTAssertEqual(sut.splashScreenImageView.imgListArray.count, 18)
        
    }

}
