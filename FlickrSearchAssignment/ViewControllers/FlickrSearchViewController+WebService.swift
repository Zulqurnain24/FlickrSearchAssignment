//
//  SearchViewController+WebService.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation

extension FlickrSearchViewController {
    
    func callSearchApi (searchText: String, pageNo: Int, _ completionHandler: (() -> Void)? = nil) {
        // use Flickr wrapper class to search Flickr for photos that match the given search term asynchronously
        // when search complets, the completion block will be called with the result set of FlickrPhoto objects and error (if there is one)
        flickr.searchFlickrDataBaseForTerm(searchText, page: pageNo) { results, paging, error in
            
            self.searchTextField.stopAnimating()
            if let paging = paging, paging.currentPage == 1 {
                ImageDownloadManager.shared.cancelAll()
               self.searches.searchResults.removeAll()
                self.collectionView?.reloadData()
            }
            
            if error != nil {
                // log any errors to the console. In production display these errors to user
                return
            }
            
            if let results = results {
                // results get logged and added to the front of the searches array
                self.searches.searchResults.append(contentsOf: results.searchResults)
                self.paging = paging
                 if completionHandler != nil {
                   completionHandler!()
                 }
                self.collectionView?.reloadData()
            }
            self.loadMore = false
        }
    }
    
}

