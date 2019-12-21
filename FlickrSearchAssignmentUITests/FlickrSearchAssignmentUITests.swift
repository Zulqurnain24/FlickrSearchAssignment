//
//  FlickrSearchAssignmentUITests.swift
//  FlickrSearchAssignmentUITests
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignmentUITests: XCTestCase {
    
    let timeIntervalForInitialAnimation = 19
    let smallDelay = 4
    let testInfiniteScrollUptil = 25
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
    }

    //UseCase - Test Search Feature By Typing Cherry
    func testImageSearch() {
      let searchTextField = app.textFields.element(boundBy: 0).firstMatch
      let exists = NSPredicate(format: "exists == 1")

      expectation(for: exists, evaluatedWith: searchTextField, handler: nil)
      waitForExpectations(timeout: TimeInterval(timeIntervalForInitialAnimation), handler: nil)
      searchTextField.tap()
      
      searchTextField.typeText("Cherry")
      searchTextField.typeText("\n")

   }
    
   //UseCase - Test Option menu Button1 Feature
   func testOptionButton1() {
        let button = app.buttons.element(boundBy: 0).firstMatch
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: button, handler: nil)
        waitForExpectations(timeout: TimeInterval(timeIntervalForInitialAnimation), handler: nil)
        button.tap()
        let sheet = app.sheets.element(boundBy: 0).firstMatch

        sheet.buttons["2 Images per row"].tap()


     }
    
    //UseCase - Test Option menu Button2 Feature
    func testOptionButton2() {
       let button = app.buttons.element(boundBy: 0).firstMatch
       let exists = NSPredicate(format: "exists == 1")

       expectation(for: exists, evaluatedWith: button, handler: nil)
       waitForExpectations(timeout: TimeInterval(timeIntervalForInitialAnimation), handler: nil)
       button.tap()
       let sheet = app.sheets.element(boundBy: 0).firstMatch

       sheet.buttons["3 Images per row"].tap()

    }
    
    //UseCase - Test Option menu Button3 Feature
    func testOptionButton3() {
       let button = app.buttons.element(boundBy: 0).firstMatch
       let exists = NSPredicate(format: "exists == 1")

       expectation(for: exists, evaluatedWith: button, handler: nil)
       waitForExpectations(timeout: TimeInterval(timeIntervalForInitialAnimation), handler: nil)
       button.tap()
       let sheet = app.sheets.element(boundBy: 0).firstMatch
 
       sheet.buttons["4 Images per row"].tap()
    }
 
    //UseCase - Test Option menu Button4 Feature
    func testOptionButton4() {
  
        let button = app.buttons.element(boundBy: 0).firstMatch
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: button, handler: nil)
        waitForExpectations(timeout: TimeInterval(timeIntervalForInitialAnimation), handler: nil)
        button.tap()
        let sheet = app.sheets.element(boundBy: 0).firstMatch
   
         sheet.buttons["Clear History"].tap()
    }
    
     //UseCase - Test Option menu Button5 Feature
    func testOptionButton5() {
    
          let button = app.buttons.element(boundBy: 0).firstMatch
          let exists = NSPredicate(format: "exists == 1")

          expectation(for: exists, evaluatedWith: button, handler: nil)
          waitForExpectations(timeout: TimeInterval(timeIntervalForInitialAnimation), handler: nil)
          button.tap()
          let sheet = app.sheets.element(boundBy: 0).firstMatch
     
           sheet.buttons["Cancel"].tap()
    }
    
     //UseCase - Test CollectionView Cell Tap After Search Term "Cherry" after deleting history
    func testCollectionViewCellTap() {
        
       testImageSearch()
       let cells = app.cells.element(boundBy: 0).firstMatch
       cells.tap()
       cells.tap()
    }
    
    //UseCase - Test DetailViewController After for Search Term "Cherry"
    func testDetailViewController() {
           
        testImageSearch()
           
        let cells = app.cells.element(boundBy: 0).firstMatch
        cells.tap()

        let detailviewcontrollerImage = app.images.element(boundBy: 0).firstMatch
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: detailviewcontrollerImage, handler: nil)
        waitForExpectations(timeout: TimeInterval(smallDelay), handler: nil)
        detailviewcontrollerImage.twoFingerTap()
        detailviewcontrollerImage.pinch(withScale: 2.0, velocity: 1.5)
        detailviewcontrollerImage.pinch(withScale: 0.5, velocity: -1.5)
        detailviewcontrollerImage.swipeRight()
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
        app.navigationBars["FlickrSearchAssignment.DetailView"].buttons["Back"].tap()
        
    }
    
    func test() {
        
    }
    
    //UseCase - Test SearchViewController CollectionView Swipe Up and Swipe Down
    func testOptionCollectionViewSwipe() {
        testImageSearch()
           
        let collectionView = app.collectionViews.element(boundBy: 0).firstMatch
        collectionView.tap()
        collectionView.swipeUp()
        collectionView.swipeDown()
                
   }
    
    //UseCase - Infinite Scroll Test
    func testCollectionViewInfiniteScroll() {
        testImageSearch()
        
        let cells = app.cells.element(boundBy: 0).firstMatch
        cells.tap()
        
        let collectionView = app.collectionViews.element(boundBy: 0).firstMatch
        for _ in 0...testInfiniteScrollUptil {
            collectionView.swipeUp()
        }
    }
}
