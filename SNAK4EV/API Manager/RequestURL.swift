//
//  APIMAnager.swift
//  Food Order
//
//  Created by Apple on 09/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

var accessToken = UserDefaults.standard.object(forKey: "accessToken") as! String

public enum RequestMethod : String
{
    
    case logIn = "signin.php"
    
    case forgotPwdApi = "forgot-password.php"
    
    case signupApi = "signup.php"
    
    case home = "home.php"
    
    case recentlyAdded = "video_list.php"
    
    case changePwdApi = "change_password.php"
    
    case profileUpdateApi = "profile_update.php"
    
    case eventApi = "event.php"
    
    case contractApi = "new_contract_video.php"
    
    case profileApi = "profile.php"

}
