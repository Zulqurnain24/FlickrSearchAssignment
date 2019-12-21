//
//  DetailViewController.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import UIKit

protocol DetailViewControllerProtocol {
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
}

/* DetailViewController
This class contains all the logic pertaining to detail view controller
*/
final class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(loadImage(_:)), name: NSNotification.Name(Constants.imageDetailNotificationName.rawValue) , object: nil)
        
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension DetailViewController: UIScrollViewDelegate {
 
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for view in scrollView.subviews where view is UIImageView {
            return view as! UIImageView
        }
        return nil
    }
    
}

extension DetailViewController: DetailViewControllerProtocol {
    
    @objc func loadImage (_ notification: Notification) {
        guard let photo = notification.object as? FlickrImage else {
            return
        }
        self.loaderView.startAnimating()
        ImageDownloadManager.shared.downloadImage(photo, indexPath: nil, size: Constants.bigImageSize.rawValue) { [weak self] (image, url, indexPathh, error) in
            if indexPathh  == nil {
                DispatchQueue.main.async {
                    self?.loaderView.stopAnimating()
                    self?.imageView.image = image
                }
            }
        }
    }

}


