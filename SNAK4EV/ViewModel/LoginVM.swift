//
//  LoginVM.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import Foundation

class LoginVM: NSObject {
    
    static let sharedInstance = LoginVM()
    var deviceDetails: [String:Any]?
    
    var loginValidation: ((String) -> Void)?
    var forgotPwdValidation: ((String) -> Void)?
    var loginSuccess: ((OTPGenerateModel) -> Void)?
    var forgotPwdSuccess: ((String) -> Void)?
    var signupValidation: ((String) -> Void)?
    var signupSuccess: ((String) -> Void)?
    var changePwdValidation: ((String) -> Void)?
    var changePwdSuccess: ((String) -> Void)?
    //var getProfileData: ((ProfileDetails) -> Void)?
    var otpSuccess: ((OTPAuthenticateModel) -> Void)?
    var tokenSuccess: ((ApiTokenModel) -> Void)?
    
    // MARK: - Init
    override init() {
        super.init()
        self.getDeviceDetails()
    }
    
    func getDeviceDetails(){
        deviceDetails = ["platform": DeviceManager.platform, "deviceId":DeviceManager.deviceId, "os":DeviceManager.os, "version":DeviceManager.version, "latitude":"", "longitude":"", "model":DeviceManager.deviceModel, "token":Globals.shared.fcmToken,"device_type":"1"]
    }
    
    func loginRequestClick(mobile: String?, vc: BaseViewController) {
        Globals.shared.shareViewController = vc
        guard mobile != "" && mobile?.count == 10 else {
            DispatchQueue.main.async {
                self.loginValidation?(MobileError)
            }
            return
        }
        let params = ["mobileno": mobile ?? "", "mobcountrycode": "91"] as [String : Any]
        self.loginRequest(param: params)
    }
    
    func loginRequest(param: [String : Any]){
        APIRequestManager.sharedInstance.otpGenerate(param:param as Dictionary<String, AnyObject>) { (success, otpGenerateModel) in
            if success
            {
                guard otpGenerateModel?.status == "success" else{
                    self.loginValidation?(otpGenerateModel?.message ?? "")
                    return
                }
                self.loginSuccess?(otpGenerateModel!)
            }
        }
    }
    
    func otpAuthenticateRequest(param: [String : Any]){
        APIRequestManager.sharedInstance.otpAuthenticate(param:param as Dictionary<String, AnyObject>) { (success, otpAuthenticateModel) in
            if success
            {
                guard otpAuthenticateModel?.status == "success" else{
                    self.loginValidation?(otpAuthenticateModel?.message ?? "")
                    return
                }
                self.otpSuccess?(otpAuthenticateModel!)
            }
        }
    }
    
    func tokenRequest(){
        APIRequestManager.sharedInstance.getAccessToken(param:[:] as Dictionary<String, AnyObject>) { (success, tokenModel) in
            if success
            {
                guard tokenModel?.status == "success" else{
                    return
                }
                self.tokenSuccess?(tokenModel!)
            }
        }
    }
    
    func signupRequestClick(firstName: String?, lastName: String?, email: String?, passsword: String?, cPasssword: String?, vc: BaseViewController) {
        Globals.shared.shareViewController = vc
        guard firstName != "" else {
            self.signupValidation?(FirstNameError)
            return
        }
        guard lastName != "" else {
            self.signupValidation?(LastNameError)
            return
        }
        guard email != "" && (email?.isValidEmail() ?? true) else {
            self.signupValidation?(ValidMailId)
            return
        }
        guard passsword != "" else {
            self.signupValidation?(PasswordError)
            return
        }
        guard cPasssword != "" else {
            self.signupValidation?(ConfirmPasswordError)
            return
        }
        guard cPasssword == passsword else {
            self.signupValidation?(EnterConfirmPasswordMatch)
            return
        }
        
        let params = ["email": email ?? "",
                      "fname" : firstName ?? "",
                      "lname": lastName ?? "",
                      "business_name":"test",
                      "password":passsword ?? "",
                      "confirm_password": cPasssword ?? "",
                      "industry":"test_industry",
                      "business_city":"test_city",
                      "state":"test_state",
                      "business_address":"business_address",
                      "business_zip":"business_zip",
                      "business_certified":"yes",
                      "business_certified_value":"mbe,wmbe,lbe/slbe,dvbe",
                      "device_details":self.deviceDetails!] as [String : Any]
        self.signupRequest(param: params)
    }
    
    func signupRequest(param: [String : Any]){
        
    }
    
    
    func changePwdRequestClick(oldPwd: String?, newPwd: String?, vc: BaseViewController) {
        Globals.shared.shareViewController = vc
        guard oldPwd != "" else {
            self.changePwdValidation?(EnterOldPassword)
            return
        }
        
        guard newPwd != "" else {
            self.changePwdValidation?(EnterNewPassword)
            return
        }
        
        let params = ["oldPwd": oldPwd ?? "", "newPwd": newPwd ?? "", "confirmPwd": newPwd ?? ""] as [String : Any]
        self.changePwdRequest(param: params)
    }
    
    func changePwdRequest(param: [String : Any]){
        
    }
    
    func profileUpdateRequestClick(firstName: String?, lastName: String?, vc: BaseViewController) {
        Globals.shared.shareViewController = vc
        guard firstName != "" else {
            self.signupValidation?(FirstNameError)
            return
        }
        
        guard lastName != "" else {
            self.signupValidation?(LastNameError)
            return
        }
        
        let params = ["business_name": "test", "business_address": "test", "fname": firstName ?? "", "lname": lastName ?? ""] as [String : Any]
        self.profileUpdateRequest(param: params)
    }
    
    func profileUpdateRequest(param: [String : Any]){
        
    }
    
    func getProfileDetails(){
        
    }
}
