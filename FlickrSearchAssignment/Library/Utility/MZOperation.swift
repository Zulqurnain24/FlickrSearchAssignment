//
//  MZOperation.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation
import UIKit

protocol MZOperationProtocol {
   func executing(_ executing: Bool)
   func finish(_ finished: Bool)
   func downloadImageFromUrl(_ completionHandler: ((UIImage) -> Void)?)
}
/* MZOperation
This entity class contains the implementation for the Operation used for downloading the images in download manager
*/
final class MZOperation: Operation, MZOperationProtocol {
    internal var downloadHandler: ImageDownloadCompletionHandler?
    internal var imageUrl: URL!
    private var indexPath: IndexPath?
   
    override var isAsynchronous: Bool {
        get {
            return  true
        }
    }
    private var _executing = false {
        willSet {
            willChangeValue(forKey: Constants.isExecuting.rawValue)
        }
        didSet {
            didChangeValue(forKey: Constants.isExecuting.rawValue)
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: Constants.isFinished.rawValue)
        }
        
        didSet {
            didChangeValue(forKey: Constants.isFinished.rawValue)
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    required init (url: URL, indexPath: IndexPath?) {
        self.imageUrl = url
        self.indexPath = indexPath
    }

    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        self.executing(true)
        //Asynchronous logic (eg: n/w calls) with callback
        self.downloadImageFromUrl()
    }
    
    func downloadImageFromUrl(_ completionHandler: ((UIImage) -> Void)? = nil) {
       let newSession = URLSession.shared
       let downloadTask = newSession.downloadTask(with: self.imageUrl) { (location, response, error) in
        if let locationUrl = location, let data = try? Data(contentsOf: locationUrl){
             let image = UIImage(data: data)
            if completionHandler != nil {
                completionHandler?(image ?? UIImage(named: "placeholder")!)
            }
            self.downloadHandler?(image, self.imageUrl, self.indexPath, error)
          }
          self.finish(true)
          self.executing(false)
        }
        downloadTask.resume()
    }
    
    
}

