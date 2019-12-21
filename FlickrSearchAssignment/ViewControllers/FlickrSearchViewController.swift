//
//  FlickrSearchViewController.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import UIKit
import PopOverMenu

protocol FlickrSearchViewControllerProtocol {
    func photoForIndexPath(indexPath: IndexPath) -> FlickrImage
    func showOptions()
    func pullDataFromPersistentStore() -> [SearchRecord]
    func showSearchHistoryMenu()
    func performSearch(searchTerm: String, _ completionHander: (() -> Void)?) -> Bool
    func showTutorial(_ completionHandler: (() -> Void)?)
}

/* FlickrSearchViewController
This class contains all the logic pertaining to search view controller
*/
final class FlickrSearchViewController: UICollectionViewController, FlickrSearchViewControllerProtocol {

    internal let separatorStyle: UITableViewCell.SeparatorStyle = .singleLine
    internal var popOverViewController: PopOverViewController?
    @IBOutlet weak var searchTextField: SearchTextField!
    internal var footerView:CustomFooterView?
    internal var searches = FlickrDatabaseSearchResults()
    internal let flickr = Flickr()
    internal var itemsPerRow: CGFloat = 3
    internal let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    internal var paging : Paging?
    internal var loadMore: Bool = false
    internal var selectedCellFrame: CGRect?
    internal var selectedIndexPath: IndexPath?
    internal let footerViewReuseIdentifier = "RefreshFooterView"
    let splashScreenImageView = Bundle.main.loadNibNamed(Constants.splashScreenImageView.rawValue, owner: self, options: nil)?.last as! SplashScreenImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView?.register(UINib(nibName: "CustomFooterView", bundle: nil),
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: footerViewReuseIdentifier)
        //Check first time user, if so then skip animation
        guard isFirstTimeUser() else {
            PersistentStoreManager.shared
                                  .setObject(key:
                                    Constants.isFirstTimeUser.rawValue, value: true)
            showTutorial()
            return}
    }

    func showTutorial(_ completionHandler: (() -> Void)? = nil) {
        splashScreenImageView.configureAnimation(behaviour: .playTutorial)
        self.view.addSubview(splashScreenImageView)
        self.view.bringSubviewToFront(splashScreenImageView)
        splashScreenImageView.initiateAnimation({
           if completionHandler != nil {
            completionHandler!()
           }
           self.splashScreenImageView.removeFromSuperview()
        })
    }
    
    func photoForIndexPath(indexPath: IndexPath) -> FlickrImage {
        return searches.searchResults[(indexPath as NSIndexPath).row]
    }
    
    @IBAction func showOptionsAction(_ sender: Any) {
        self.searchTextField.resignFirstResponder()
        self.showOptions()
    }
    
    func showOptions() {
        //Hide tutorial animation if there is any while search field editing
        splashScreenImageView.isHidden = true
        
        let actionSheetController: UIAlertController = UIAlertController(title: Constants.title.rawValue, message: Constants.options.rawValue, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: Constants.alertCancelButtonTitle.rawValue, style: .cancel) { _ in

        }
        actionSheetController.addAction(cancelActionButton)
        
        let option1 = UIAlertAction(title: Constants.alertTitle2.rawValue, style: .default)
        { _ in

            self.itemsPerRow = 2
            self.collectionView?.reloadData()
        }
        option1.accessibilityValue = Constants.alertTitle2.rawValue
        option1.accessibilityActivate()
        actionSheetController.addAction(option1)
        
        let option2 = UIAlertAction(title: Constants.alertTitle3.rawValue, style: .default)
        { _ in

            self.itemsPerRow = 3
            self.collectionView?.reloadData()
        }
        option2.accessibilityValue = Constants.alertTitle3.rawValue
        option2.accessibilityActivate()
        actionSheetController.addAction(option2)
        let option3 = UIAlertAction(title: Constants.alertTitle4.rawValue, style: .default)
        { _ in

            self.itemsPerRow = 4
            self.collectionView?.reloadData()
        }
        option3.accessibilityValue = Constants.alertTitle4.rawValue
        option3.accessibilityActivate()
        actionSheetController.addAction(option3)
        let option4 = UIAlertAction(title: Constants.clearHistory.rawValue, style: .default)
               { _ in
                   PersistentStoreManager.shared.clearData(Constants.searchHistoryKey.rawValue)
               }
        option4.accessibilityValue = Constants.clearHistory.rawValue
        option4.accessibilityActivate()
        actionSheetController.addAction(option4)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func isFirstTimeUser() -> Bool {
        guard let isFirstTimeUser = PersistentStoreManager.shared.getObject(Constants.isFirstTimeUser.rawValue,
                        Bool.self) as Bool? else { return false }
        return isFirstTimeUser
    }
    
    func pullDataFromPersistentStore() -> [SearchRecord] {
        guard let searchHistoryStrings = PersistentStoreManager.shared.getObject(Constants.searchHistoryKey.rawValue,
                        Array<SearchRecord>.self) as [SearchRecord]? else { return [] }
        return searchHistoryStrings
    }
    
    func showSearchHistoryMenu() {
        self.popOverViewController = PopOverViewController.instantiate()

        let searchRecords = pullDataFromPersistentStore()

        self.popOverViewController?.setArrayForBarButtonItem(delegate: self, barButtonItem: self.navigationItem.rightBarButtonItem!, titles: searchRecords.map({$0.string}),
         descriptions: searchRecords.map({$0.time}),
         separatorStyle: separatorStyle) { (selectRow) in
           self.searchTextField.text = searchRecords[selectRow].string
           let _ = self.performSearch(searchTerm:  self.searchTextField.text ?? "")
         }

         if let popOverViewController = self.popOverViewController {
           present(popOverViewController, animated: true, completion: nil)
         }
    }
    
    func performSearch(searchTerm: String, _ completionHander: (() -> Void)? = nil) -> Bool {
           self.paging = nil
           self.loadMore = true
           guard let searchText = searchTerm as String?, searchText.count > 0 else {
               ImageDownloadManager.shared.cancelAll()
               self.searches.searchResults.removeAll()
               self.collectionView?.reloadData()
               self.loadMore = false
               guard completionHander != nil else {
                  return true
               }
               completionHander!()
               return true
           }
           
           var searchRecords = pullDataFromPersistentStore()
           if searchRecords.count > 9 {
               searchRecords.removeFirst()
           }
           searchRecords.append(SearchRecord(string: searchText, time: "\(Date())"))
           
            PersistentStoreManager.shared.clearData(Constants.searchHistoryKey.rawValue)
            PersistentStoreManager.shared.setObject(key: Constants.searchHistoryKey.rawValue,
                                                                        value: searchRecords)
           
           searchTextField.startAnimating()
            self.callSearchApi(searchText: searchText, pageNo: 1, {
            guard completionHander != nil else {
                return
            }
            completionHander!()
            })
           
        return true
    }
}

// MARK: UIAdaptivePresentationControllerDelegate
extension FlickrSearchViewController: UIAdaptivePresentationControllerDelegate {

       func adaptivePresentationStyle(for controller: UIPresentationController)
        -> UIModalPresentationStyle {
           return UIModalPresentationStyle.none
       }

       func adaptivePresentationStyle(for controller: UIPresentationController,
                                      traitCollection: UITraitCollection) -> UIModalPresentationStyle {
           return UIModalPresentationStyle.none
       }
}

// MARK: UITextFieldDelegate
extension FlickrSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //Hide tutorial animation if there is any while search field editing
        splashScreenImageView.isHidden = true
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         guard let searchHistoryStrings = pullDataFromPersistentStore() as [SearchRecord]?,
                !searchHistoryStrings.isEmpty else { return }
         showSearchHistoryMenu()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return performSearch(searchTerm: textField.text ?? "")
    }
}
