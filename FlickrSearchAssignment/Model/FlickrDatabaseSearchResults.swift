//
//  FlickrDatabaseSearchResults.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation

/* FlickrDatabaseSearchResults
This entity struct contains the implementation for collection data type for populating the downloaded images and the search term
*/
struct FlickrDatabaseSearchResults {
  internal let searchTerm : String = ""
  internal var searchResults = [FlickrImage]()
}

