//
//  SearchTextField.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import UIKit

protocol SearchTextFieldProtocol {
    func startAnimating()
    func stopAnimating()
}

/* SearchTextField
This class contains all the logic for search field
*/
final class SearchTextField: UITextField {
    var activityIndicator : UIActivityIndicatorView!
    
    override func awakeFromNib() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        activityIndicator.frame = self.bounds
    }
   
}

extension SearchTextField: SearchTextFieldProtocol {
    
       func startAnimating () {
           activityIndicator.startAnimating()
       }
       
       func stopAnimating () {
           activityIndicator.stopAnimating()
       }

}
