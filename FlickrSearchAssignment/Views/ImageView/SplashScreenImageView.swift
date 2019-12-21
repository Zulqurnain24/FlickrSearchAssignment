//
//  SplashScreenImageView.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import UIKit

enum Behaviour: Int, CaseIterable {
   case playSplashAnimation = 0
   case playTutorial
}

protocol SplashScreenImageViewProtocol {
    func configureAnimation(behaviour: Behaviour)
    func initiateAnimation( _ completionHandler: (() -> Void)?)
}

/* SplashScreenImageView
This class contains all the logic for the imageview used for showing splash and tutorial animations
*/
final class SplashScreenImageView: UIImageView, SplashScreenImageViewProtocol {

    internal var duration: Double!
    internal let imgListArray: NSMutableArray = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureAnimation(behaviour: Behaviour) {
        var animationImageName = ""
        switch behaviour {
            case .playSplashAnimation:
                animationImageName = "collage"
                duration = Double(Constants.splashAnimationTimeInSeconds.rawValue)
            case .playTutorial:
                animationImageName = "tutorial"
                duration = Double(Constants.tutorialAnimationTimeInSeconds.rawValue)
        }
        for countValue in 1...9
        {
            
            guard let strImageName = "\(animationImageName)\(countValue).png" as String?,
                  let image  = UIImage(named: strImageName) else { return }
            
            imgListArray.add(image)
        }
        self.backgroundColor = .clear
        self.animationImages = imgListArray as? [UIImage];
        self.animationDuration = TimeInterval(duration ?? 0.0)
    }
    
    func initiateAnimation( _ completionHandler: (() -> Void)? = nil) {
        self.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? 0.0), execute: {
            self.stopAnimating()
           if completionHandler != nil {
              completionHandler!()
           }
        })
    }
    
}
