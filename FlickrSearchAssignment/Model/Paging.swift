//
//  Paging.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation

/* Paging
This entity class contains the implementation for the Paging attributes
*/
internal class Paging {

    // MARK: Properties
    internal var totalPages: Int?
    internal var numberOfElements: Int32?
    internal var currentSize: Int = 20
    internal var currentPage: Int?

    init(totalPages: Int, elements: Int32, currentPage: Int) {
        self.totalPages = totalPages
        self.numberOfElements = elements
        self.currentPage = currentPage
    }
}
