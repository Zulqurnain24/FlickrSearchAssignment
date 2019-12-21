//
//  Enums.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

/* Enums
This class contains all the enums
*/
enum Constants: String, CaseIterable  {
    case searchHistoryKey = "searchHistoryKey"
    case title = "FlickrSearchAssignment"
    case splashToTutorialScreenTransition = "splashToTutorialScreenTransition"
    case splashScreenImageView = "SplashScreenImageView"
    //Set Splash Animation time here
    case splashAnimationTimeInSeconds = "9"
    //Set Tutorial Animation time here
    case tutorialAnimationTimeInSeconds = "10"
    case options = "Options"
    case alertTitle2 = "2 Images per row"
    case alertTitle3 = "3 Images per row"
    case alertTitle4 = "4 Images per row"
    case clearHistory = "Clear History"
    case alertCancelButtonTitle = "Cancel"
    case imageDetailNotificationName = "LoadImage"
    case bigImageSize = "b"
    case middleImageSize = "m"
    case defaultConfig = "Default Configuration"
    case endpointPrefix = "https://farm"
    case endpointMiddle = ".staticflickr.com/"
    case imageFormat = ".jpg"
    case apiKey = "80dfc8a974090130914f01c22b5d103d"
    case unknownApiResponse = "Unknown API response"
    case ok = "ok"
    case fail = "fail"
    case message = "Results processed OK"
    case flickrApiPrefix = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key="
    case flickrApiMiddle = "&text="
    case flickrApiPostFix = "&per_page=20&format=json&nojsoncallback=1&page="
    case isExecuting = "isExecuting"
    case isFinished = "isFinished"
    
    case statKey = "stat"
    case messageKey = "message"
    case photoKey = "photo"
    case photosKey = "photos"
    case idKey = "id"
    case farmKey = "farm"
    case serverKey = "server"
    case secretKey = "secret"
    case pageKey = "page"
    case pagesKey = "pages"
    case totalKey = "total"
    case isFirstTimeUser = "isFirstTimeUser"
}
