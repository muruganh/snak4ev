//
//  DeviceManager.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import Foundation
import UIKit

enum DeviceSize : CGFloat
{
    case SMALLSIZE = 320,  MEDIUMSIZE = 375, PLUSSIZE = 414
}

public struct DeviceManager
{
    
    public static var udid: String
    {
        return UIDevice.current.identifierForVendor!.uuidString//DeviceHelpers.deviceID()
    }
    
    public static var deviceId: String
    {
        return UIDevice.current.identifierForVendor!.uuidString//DeviceHelpers.deviceID()
    }
    
    public static var deviceModel: String
    {
        return UIDevice.current.model;
    }
    
    public static var platform : String
    {
        return "ios"
    }
    
    public static var version : String
    {
        return  (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    }
    
    public static var os : String{
        
        return UIDevice.current.systemVersion
    }
    
    
    public static var deviceHeight : CGFloat{
        return UIScreen.main.bounds.size.height
            
    }
    
    public static var deviceWidth : CGFloat{
        return UIScreen.main.bounds.size.width
        
    }
   
}
