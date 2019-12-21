//
//  CustomFooterView.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation
import UIKit

protocol CustomFooterViewProtocol {
    func setTransform(inTransform: CGAffineTransform, scaleFactor:CGFloat)
    func prepareInitialAnimation()
    func startAnimate()
    func stopAnimate()
    func animateFinal()
}

/* CustomFooterView
This class contains all the logic for footer cell in uicollectionview for searched images
*/
final class CustomFooterView : UICollectionReusableView, CustomFooterViewProtocol {
   
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
    var isAnimatingFinal:Bool = false
    var currentTransform:CGAffineTransform?

    override func awakeFromNib() {
        super.awakeFromNib()
        //refreshControlIndicator.color = UIColor.green
        self.prepareInitialAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setTransform(inTransform: CGAffineTransform, scaleFactor:CGFloat) {
        if isAnimatingFinal {
            return
        }
        self.currentTransform = inTransform
        self.refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    //reset the animation
    func prepareInitialAnimation() {
        self.isAnimatingFinal = false
        self.refreshControlIndicator?.stopAnimating()
        self.refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
    
    func startAnimate() {
        self.isAnimatingFinal = true
        self.refreshControlIndicator?.startAnimating()
    }
    
    func stopAnimate() {
        self.isAnimatingFinal = false
        self.refreshControlIndicator?.stopAnimating()
    }
    
    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.refreshControlIndicator?.transform = CGAffineTransform.identity
        }
    }
}

