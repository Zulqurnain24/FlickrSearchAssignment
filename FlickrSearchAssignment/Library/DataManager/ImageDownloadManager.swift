//
//  ImageDownloadManager.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation
import UIKit

typealias ImageDownloadCompletionHandler = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath?, _ error: Error?) -> Void

protocol ImageDownloadManagerProtocol {
   func downloadImage(_ flickrPhoto: FlickrImage, indexPath: IndexPath?, size: String, handler: @escaping ImageDownloadCompletionHandler)
   func slowDownImageDownloadTaskfor (_ flickrPhoto: FlickrImage)
   func cancelAll()
}

/* ImageDownloadManager
This entity class contains the implementation for downloading the flickr images from the web
*/
final class ImageDownloadManager {
    private var completionHandler: ImageDownloadCompletionHandler?
    internal lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.flickrSearchAssignment.imagesDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    internal let imageCache = NSCache<NSString, UIImage>()
    internal static let shared = ImageDownloadManager()
    private init () {}
    
    func downloadImage(_ flickrPhoto: FlickrImage, indexPath: IndexPath?, size: String = Constants.middleImageSize.rawValue, handler: @escaping ImageDownloadCompletionHandler) {
        self.completionHandler = handler
        guard let url = flickrPhoto.flickrImageURL(size) else {
            return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            /* check for the cached image for url, if YES then return the cached image */
           self.completionHandler?(cachedImage, url, indexPath, nil)
        } else {
             /* check if there is a download task that is currently downloading the same image. */
            if let operations = (imageDownloadQueue.operations as? [MZOperation])?.filter({$0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
                operation.queuePriority = .veryHigh
            }else {
                /* create a new task to download the image.  */
                let operation = MZOperation(url: url, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .high
                }
                operation.downloadHandler = { (image, url, indexPath, error) in
                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                    self.completionHandler?(image, url, indexPath, error)
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    /* FUNCTION to reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
    func slowDownImageDownloadTaskfor (_ flickrPhoto: FlickrImage) {
        guard let url = flickrPhoto.flickrImageURL() else {
            return
        }
        if let operations = (imageDownloadQueue.operations as? [MZOperation])?.filter({$0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
            operation.queuePriority = .low
        }
    }
    
    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
    
}

