//
//  FlickrSearchAssignment_EnumsTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_EnumsTest: XCTestCase {
   override func setUp() {
       super.setUp()
   }
   
   override func tearDown() {
       super.tearDown()
   }
   
   func testEnums() {
    //Test Constants enums
    XCTAssertEqual(Constants.searchHistoryKey.rawValue, "searchHistoryKey")
    XCTAssertEqual(Constants.title.rawValue, "FlickrSearchAssignment")
    XCTAssertEqual(Constants.splashToTutorialScreenTransition.rawValue, "splashToTutorialScreenTransition")
    XCTAssertEqual(Constants.splashScreenImageView.rawValue, "SplashScreenImageView")
    XCTAssertEqual(Constants.splashAnimationTimeInSeconds.rawValue, "9")
    XCTAssertEqual(Constants.options.rawValue, "Options")
    XCTAssertEqual(Constants.alertTitle2.rawValue, "2 Images per row")
    XCTAssertEqual(Constants.alertTitle3.rawValue, "3 Images per row")
    XCTAssertEqual(Constants.alertTitle4.rawValue, "4 Images per row")
    XCTAssertEqual(Constants.clearHistory.rawValue, "Clear History")
    XCTAssertEqual(Constants.alertCancelButtonTitle.rawValue, "Cancel")
    XCTAssertEqual(Constants.clearHistory.rawValue, "Clear History")
     
    XCTAssertEqual(Constants.bigImageSize.rawValue, "b")
    XCTAssertEqual(Constants.middleImageSize.rawValue, "m")
    XCTAssertEqual(Constants.defaultConfig.rawValue, "Default Configuration")
    
    XCTAssertEqual(Constants.endpointPrefix.rawValue, "https://farm")
    XCTAssertEqual(Constants.endpointMiddle.rawValue, ".staticflickr.com/")
    XCTAssertEqual(Constants.endpointPrefix.rawValue, "https://farm")
    XCTAssertEqual(Constants.imageFormat.rawValue, ".jpg")
    
    XCTAssertEqual(Constants.unknownApiResponse.rawValue, "Unknown API response")
    XCTAssertEqual(Constants.ok.rawValue, "ok")
    XCTAssertEqual(Constants.fail.rawValue, "fail")
    XCTAssertEqual(Constants.message.rawValue, "Results processed OK")
    XCTAssertEqual(Constants.photosKey.rawValue, "photos")
    XCTAssertEqual(Constants.idKey.rawValue, "id")
    XCTAssertEqual(Constants.farmKey.rawValue, "farm")
    XCTAssertEqual(Constants.serverKey.rawValue, "server")
    XCTAssertEqual(Constants.secretKey.rawValue, "secret")
    XCTAssertEqual(Constants.pageKey.rawValue, "page")
    XCTAssertEqual(Constants.pagesKey.rawValue, "pages")
    XCTAssertEqual(Constants.totalKey.rawValue, "total")
    XCTAssertEqual(Constants.flickrApiMiddle.rawValue, "&text=")
    XCTAssertEqual(Constants.flickrApiPostFix.rawValue, "&per_page=20&format=json&nojsoncallback=1&page=")
    XCTAssertEqual(Constants.isExecuting.rawValue, "isExecuting")
    XCTAssertEqual(Constants.isFinished.rawValue, "isFinished")
    XCTAssertEqual(Constants.isFirstTimeUser.rawValue, "isFirstTimeUser")
    XCTAssertEqual(Constants.splashAnimationTimeInSeconds.rawValue, "9")
    XCTAssertEqual(Constants.tutorialAnimationTimeInSeconds.rawValue, "10")
    XCTAssertEqual(Constants.allCases.count, 41)
    
    //Test Behaviour enums
    XCTAssertEqual(Behaviour.playSplashAnimation.rawValue, 0)
    XCTAssertEqual(Behaviour.playTutorial.rawValue, 1)
    XCTAssertEqual(Behaviour.allCases.count, 2)
   }
}
