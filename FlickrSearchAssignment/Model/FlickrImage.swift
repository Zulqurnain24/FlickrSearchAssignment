//
//  FlickrImage.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import UIKit

protocol FlickrImageProtocol {
    func flickrImageURL(_ size:String) -> URL?
}

/* FlickrImage
This entity class contains the implementation for the downloaded Image attributes
*/
class FlickrImage : Equatable, FlickrImageProtocol {
  internal let photoID : String
  internal let farm : Int
  internal let server : String
  internal let secret : String
  
  init (photoID:String,farm:Int, server:String, secret:String) {
    self.photoID = photoID
    self.farm = farm
    self.server = server
    self.secret = secret
  }
  
  func flickrImageURL(_ size:String = Constants.middleImageSize.rawValue) -> URL? {
        if let url =  URL(string: "\(Constants.endpointPrefix.rawValue)\(farm)\(Constants.endpointMiddle.rawValue)\(server)/\(photoID)_\(secret)_\(size)\(Constants.imageFormat.rawValue)") {
      return url
    }
    return nil
  }
  
}

func == (lhs: FlickrImage, rhs: FlickrImage) -> Bool {
  return lhs.photoID == rhs.photoID
}

