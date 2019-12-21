//
//  SplashScreenViewController.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import UIKit

protocol SplashScreenViewControllerProtocol {
    func setupViews(_ completionHandler: (() -> Void)?)
    func performSegueToTutorialViewController()
}

/* SplashScreenViewController
This class contains all the logic pertaining to splash view controller
*/
final class SplashScreenViewController: UIViewController {

    @IBOutlet weak var splashAnimationView: UIView!

    let splashScreenImageView = Bundle.main.loadNibNamed(Constants.splashScreenImageView.rawValue, owner: self, options: nil)?.last as! SplashScreenImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

}

extension SplashScreenViewController: SplashScreenViewControllerProtocol {
   
    func setupViews(_ completionHandler: (() -> Void)? = nil) {
    
        splashScreenImageView.configureAnimation(behaviour: .playSplashAnimation)
        splashAnimationView.addSubview(splashScreenImageView)
        splashScreenImageView.initiateAnimation({
            if completionHandler != nil {
                completionHandler!()
            }
            self.performSegueToTutorialViewController()
        })
    }
    
    func performSegueToTutorialViewController() {
        performSegue(withIdentifier: Constants.splashToTutorialScreenTransition.rawValue, sender: self)
    }

}

