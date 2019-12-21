//
//  Flickr.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import UIKit

protocol FlickrProtocol {
    func searchFlickrDataBaseForTerm(_ searchTerm: String, page: Int,completion : @escaping (_ results: FlickrDatabaseSearchResults?, _ paging: Paging?,_ error : NSError?) -> Void)
    func flickrSearchURLForSearchTerm(_ searchTerm:String, page: Int) -> URL?
}

/* Flickr
This entity class contains the implementation for actual search methods which are responsible for fetching the searched images pertaining to the search term for consecutive pages
*/
final class Flickr: FlickrProtocol {

    internal func searchFlickrDataBaseForTerm(_ searchTerm: String, page: Int = 1,completion : @escaping (_ results: FlickrDatabaseSearchResults?, _ paging: Paging?,_ error : NSError?) -> Void) {
        
        guard let searchURL = flickrSearchURLForSearchTerm(searchTerm,page: page) else {
            let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey: Constants.unknownApiResponse.rawValue])
            completion(nil, nil,APIError)
            return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        URLSession.shared.dataTask(with: searchRequest, completionHandler: { (data, response, error) in
            
            if let _ = error {
                let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:Constants.unknownApiResponse.rawValue])
                OperationQueue.main.addOperation({
                    completion(nil, nil,APIError)
                })
                return
            }
            
            guard let _ = response as? HTTPURLResponse,
                let data = data else {
                    let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:Constants.unknownApiResponse.rawValue])
                    OperationQueue.main.addOperation({
                        completion(nil, nil,APIError)
                    })
                    return
            }
            
            do {
                
                guard let resultsDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject],
                    let stat = resultsDictionary["stat"] as? String else {
                        
                        let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:Constants.unknownApiResponse.rawValue])
                        OperationQueue.main.addOperation({
                            completion(nil, nil,APIError)
                        })
                        return
                }
                
                switch (stat) {
                case Constants.ok.rawValue:
                    print(Constants.message.rawValue)
                case Constants.fail.rawValue:
                    if let message = resultsDictionary[Constants.messageKey.rawValue] {
                        
                        let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:message])
                        
                        OperationQueue.main.addOperation({
                            completion(nil, nil,APIError)
                        })
                    }
                    
                    let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: nil)
                    
                    OperationQueue.main.addOperation({
                        completion(nil, nil,APIError)
                    })
                    
                    return
                default:
                    let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:Constants.unknownApiResponse.rawValue])
                    OperationQueue.main.addOperation({
                        completion(nil, nil,APIError)
                    })
                    return
                }
                guard let photosContainer = resultsDictionary[Constants.photosKey.rawValue] as? [String: AnyObject], let photosReceived = photosContainer[Constants.photoKey.rawValue] as? [[String: AnyObject]] else {
                    
                    let APIError = NSError(domain: Constants.title.rawValue, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:Constants.unknownApiResponse.rawValue])
                    OperationQueue.main.addOperation({
                        completion(nil, nil,APIError)
                    })
                    return
                }
                var paging : Paging?
                var flickrPhotos = [FlickrImage]()
                
                for photoObject in photosReceived {
                    guard let photoID = photoObject[Constants.idKey.rawValue] as? String,
                        let farm = photoObject[Constants.farmKey.rawValue] as? Int ,
                        let server = photoObject[Constants.serverKey.rawValue] as? String ,
                        let secret = photoObject[Constants.secretKey.rawValue] as? String else {
                            break
                    }
                    let flickrPhoto = FlickrImage(photoID: photoID, farm: farm, server: server, secret: secret)
                    flickrPhotos.append(flickrPhoto)
                }
                
                if let currentPage = photosContainer[Constants.pageKey.rawValue] as? Int,
                    let totalPages = photosContainer[Constants.pagesKey.rawValue] as? Int ,
                    let numberOfElements = photosContainer[Constants.totalKey.rawValue] as? String {
                    paging = Paging(totalPages: totalPages, elements: Int32(numberOfElements)!, currentPage: currentPage)
                }
                
                OperationQueue.main.addOperation({
                    completion(FlickrDatabaseSearchResults(searchResults: flickrPhotos),paging ,nil)
                })
                
            } catch _ {
                completion(nil, nil,nil)
                return
            }
            
            
        }) .resume()
    }
    
    internal func flickrSearchURLForSearchTerm(_ searchTerm:String, page: Int = 1) -> URL? {
        
        guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        
        let URLString = "\(Constants.flickrApiPrefix.rawValue)\(Constants.apiKey.rawValue)\(Constants.flickrApiMiddle.rawValue)\(escapedTerm)\(Constants.flickrApiPostFix.rawValue)\(page)"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }
}

