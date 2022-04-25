//
//  AppConstants.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import UIKit

public typealias GenericClosure<T> = (_ value: T)->()

enum App: String{
    case AppTheme = "#F1B000"
    case TabUnselectedColor = "#6b6b6b"
    
    var Color : UIColor {
        return UIColor.init(colorCode: self.rawValue)!
    }
}

enum ImageName: String{
    case Back = "back"
    
    var image : UIImage {
        return UIImage.init(named: self.rawValue)!
    }
}

enum Storyboards : String {
    case Main = "Main"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}

struct Constants{
    static var sharedInstance = Constants()
}

enum ViewAll: String{
    case recently_added = "recently_added"
    case recommended_video = "recommended_video"
    case top_viewed_videos = "top_viewed_videos"
    case recentlyAddedTitle = "Recently Added"
    case recommendedVideoTitle = "Recommended Videos"
    case topViewedVideoTitle = "Top Viewed Videos"
}
