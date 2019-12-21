//
//  FlickrSearchAssignment_SplashScreenImageViewTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_SplashScreenImageViewTest: XCTestCase {
    let timeInterval1 = 15.0
    let timeInterval2 = 19.0
    var sut: SplashScreenImageView!
    override func setUp() {
        sut = Bundle.main.loadNibNamed(Constants.splashScreenImageView.rawValue, owner: self, options: nil)?.last as? SplashScreenImageView
    }

    override func tearDown() {
       
        sut = nil
        
        super.tearDown()
    }

    //Test SplashScreenImageView SplashAnimation logic
    func testSplashScreenImageViewForSplashAnimation() {
        let expectation = self.expectation(description: "Animation")
        sut.configureAnimation(behaviour: Behaviour.playSplashAnimation)
        sut.initiateAnimation({
            print("Animation completed!")
            expectation.fulfill()
        })
        waitForExpectations(timeout: timeInterval1, handler: nil)

        XCTAssertEqual(sut.imgListArray.count, 9, "animationImages test")
    }
    
    //Test SplashScreenImageView TutorialAnimation logic
    func testSplashScreenImageViewForTutorialAnimation() {
        let expectation = self.expectation(description: "Animation")
        sut.configureAnimation(behaviour: Behaviour.playTutorial)
        sut.initiateAnimation({
            print("Tutorial completed!")
            expectation.fulfill()
        })
        waitForExpectations(timeout: timeInterval2, handler: nil)

        XCTAssertEqual(sut.imgListArray.count, 9, "animationImages test")
    }

}
