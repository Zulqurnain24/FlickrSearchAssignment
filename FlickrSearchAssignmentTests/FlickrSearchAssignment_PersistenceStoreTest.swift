//
//  FlickrSearchAssignment_PersistenceStoreTest.swift
//  FlickrSearchAssignmentTests
//
//  Created by Zulqurnain on 12/19/19.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import XCTest
@testable import FlickrSearchAssignment

class FlickrSearchAssignment_PersistenceStoreTest: XCTestCase {
    
    var sut: PersistentStoreManager!
    
    override func setUp() {
        super.setUp()
        
        sut = PersistentStoreManager()
    }
    
    override func tearDown() {

        sut = nil
        
        super.tearDown()
    }

    //Test persistenceStore isNil list logic
    func testIsListNil() {
        PersistentStoreManager.shared.clearData(Constants.searchHistoryKey.rawValue)
        let searchRecords = PersistentStoreManager.shared.getObject(Constants.searchHistoryKey.rawValue, Array<SearchRecord>.self) as [SearchRecord]?
        XCTAssertNil(searchRecords, "searchRecords from persistence store test")
    }
    
    //Test persistenceStore IsListSaved list logic
    func testIsListSaved() {
        let testSearchRecord = SearchRecord(string: "Apple", time: "19/25/2019T13:30:00.000")
        PersistentStoreManager.shared.setObject(key: Constants.searchHistoryKey.rawValue, value: [testSearchRecord])
        let searchRecords = PersistentStoreManager.shared.getObject(Constants.searchHistoryKey.rawValue, Array<SearchRecord>.self) as [SearchRecord]?
        XCTAssertNotNil(searchRecords, "searchRecords from persistence store  list type test")
    }

    //Test persistenceStore ObjectType logic
    func testObjectType() {
        XCTAssertTrue(sut.objectIsOfType(true as AnyObject, Bool.self), "test ObjectType")
    }
    
    //Test persistenceStore NonListSaved logic
    func testIsNonListSaved() {

        PersistentStoreManager.shared.setObject(key: Constants.isFirstTimeUser.rawValue, value: true)
        let isFirstTimeUser = (PersistentStoreManager.shared.getObject(Constants.isFirstTimeUser.rawValue, Bool.self) as Bool?)!
        XCTAssertTrue(isFirstTimeUser, "searchRecords from persistence store non list type test")
    }
   
}
