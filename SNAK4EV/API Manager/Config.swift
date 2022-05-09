//
//  AppDelegate.swift
//  MealBrite
//
//  Created by Murugan on 15/07/20.
//  Copyright © 2020 Murugan. All rights reserved.
//

import Foundation

let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String

let isProduction = true

let PrintLog: Bool = false

let liveEnv = "https://www.speedp.live/snak4ev/"

let devEnv = "https://www.speedp.live/snak4ev/"

let baseURL = isProduction ? liveEnv : devEnv

let googleAddressApiKey = "AIzaSyA0CiZZvu4LCQDBZ9PyP3nmH3DxlWd9m2c"

let googleProvideAPIKey = "AIzaSyA0CiZZvu4LCQDBZ9PyP3nmH3DxlWd9m2c"

let razorDevKey = "rzp_test_UNIYnViM67Qrcr"

let razorLiveKey = "rzp_live_lC8JXJGsIBVPk5"

let razorApiKey = isProduction ? razorLiveKey : razorDevKey

let NameLength: Int = 15

let PasswordLength: Int = 15

let EmailLength: Int = 40

let MobileLength: Int = 14

let SearchCharacterLength = 20

let DescriptionLength: Int = 500

let PriceLength: Int = 10

let LocationLength: Int = 100

let ZipcodeLength: Int = 20

let PopupSuccess = "success"

let PopupError = "error"

let PopupWarning = "warning"

let PopupInfo = "info"

let Success = "Success"

let successCode = 200 ... 299

let GoogleAddressApiKey = "AIzaSyDR23mfvFENPRkrpyguiXgB4qhjemohqYg"

let autoCompleteApi = "https://maps.googleapis.com/maps/api/place/autocomplete/json?&components=country:in&key=\(GoogleAddressApiKey)&input="

let autoCompletePlaceDetails = "https://maps.googleapis.com/maps/api/place/details/json?&key=\(GoogleAddressApiKey)&place_id="
