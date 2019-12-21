//
//  FlickrSearchAssignment_FlickrSearchViewControllerTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_FlickrSearchViewControllerTest: XCTestCase {
 
    var sut: FlickrSearchViewController!
    let timeInterval1 = 4.0
    let timeInterval2 = 19.0
    let timeInterval3 = 5.0
    override func setUp() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FlickrSearchViewController") as? FlickrSearchViewController
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testFlickrSearchViewController() {

        //Test Display logic
        sut.loadView()
        sut.viewDidLoad()
        sut.viewDidAppear(false)
        sut.searchTextField.text = "Bubble"
    
        //Test tutorial logic
        let expectation1 = self.expectation(description: "Show Tutorial")

        sut.showTutorial({
            expectation1.fulfill()
        })
        
        waitForExpectations(timeout: timeInterval2, handler: nil)
        
        //Test Search logic
        let expectation2 = self.expectation(description: "Search Cherry")

        let isSearchSuccessful = sut.performSearch(searchTerm: sut.searchTextField.text!, {
          expectation2.fulfill()
     
            self.sut.collectionView.reloadData()
        })
        
        waitForExpectations(timeout: timeInterval1, handler: nil)
        XCTAssertTrue(isSearchSuccessful, "Search Successful")
        XCTAssertTrue(sut.searches.searchResults.count > 0, "Search results are more than one for Search term \(sut.searchTextField.text!)")
  
        //Test photoForIndexPath logic
        XCTAssertNotNil(sut.photoForIndexPath(indexPath: IndexPath(row: 0, section: 0)))
        
        //Test searchTextField logic
        sut.showOptionsAction(sut.searchTextField!)
        XCTAssertFalse(sut.searchTextField.isFirstResponder, "searchTextField is not first responder Test")
        XCTAssertTrue(sut.performSearch(searchTerm: "Cherry"), "performSearch Test")
        XCTAssertTrue(sut.pullDataFromPersistentStore().count > 0, "pullDataFromPersistentStore Test")
        XCTAssertTrue(sut.textFieldShouldReturn(sut.searchTextField), "Textfield textFieldShouldReturn delegate method Test")
        
        //Test selectedIndexPath logic
        sut.selectedIndexPath = IndexPath(row: 0, section: 0)
        
        //Test notification logic
        sut.searches.searchResults.append(FlickrImage(photoID: "49245937158", farm: 66, server: "65535", secret: "d91eb1f965"))
        sut.postNotification()
        XCTAssertNotNil(Notification(name: Notification.Name(rawValue: "TestNotification")), "Test DetailView Notification")

        XCTAssertTrue(sut.searches.searchResults.count > 0, "Records reloaded")

        let notificationCenter = NotificationCenter()

        let notificationExpectation = expectation(forNotification: NSNotification.Name(Constants.imageDetailNotificationName.rawValue),
                                                           object: sut,
                                                           notificationCenter: notificationCenter,
                                                          handler: nil)

        sut.postNotification({notificationExpectation.fulfill()})
        
        waitForExpectations(timeout: timeInterval3, handler: nil)
        
        //Test collection view delegate logic
        XCTAssertTrue(sut.numberOfSections(in: sut.collectionView) == 1, "Number of sections")
        
        XCTAssertTrue(sut.collectionView(sut.collectionView, numberOfItemsInSection: 0) >= 0, "Number of sections")

        XCTAssertNotNil(sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)), "Test cellForItemAt")
        
        let paddingSpace = sut.sectionInsets.left * (sut.itemsPerRow + 1)
        let availableWidth = sut.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / sut.itemsPerRow
        
        XCTAssertEqual(sut.collectionView(sut.collectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0)), CGSize(width: widthPerItem, height: widthPerItem), "Test cellForItemAt")
        
        XCTAssertTrue(sut.textFieldShouldBeginEditing(sut.searchTextField), "Test Textfield FieldShouldBeginEditing")

        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        //search history method
        sut.showSearchHistoryMenu()
        XCTAssertTrue(sut.pullDataFromPersistentStore().count > 0, "Test search history")
    }

}
