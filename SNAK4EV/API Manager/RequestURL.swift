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
    
    case otpGenerate = "OtpGeneration/"
    
    case otpAuthenticate = "OtpAuthentication/"
    
    case getTokenApi = "GetToken/"
    
    case getWalletBalanceApi = "GetWalletBalance/"
    
    case updateWalletApi = "LoadWallet/"
    
    case profileUpdateApi = "CustomerUpdate/"
    
    case getProfileApi = "GetCustomer/"
    
    case getChargerDetailsApi = "GetChargerQRCode/"
    
    case getChargeStationListApi = "https://api.edrv.io/v1.1/chargestations"
    
    case getChargeLocationApi = "https://api.edrv.io/v1.1/locations/"
    

}
