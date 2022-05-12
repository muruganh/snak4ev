//
//  ProfileVM.swift
//  SNAK4EV
//
//  Created by Apple  on 02/05/22.
//

import Foundation

class ProfileVM: NSObject{
    static let sharedInstance = ProfileVM()
    var profileDetails: ((ProfileModel) -> Void)?
    var updateValidation: ((String, Bool) -> Void)?
    var vc: BaseViewController?
    
    func getProfile(){
        let params = ["customerid": OTPUserDetails.OTPDetailModel?.customerid ?? ""] as [String : Any]
        self.getProfileRequest(params: params)
    }
    
    func getProfileRequest(params: [String: Any]){
        APIRequestManager.sharedInstance.getProfile(param:params as Dictionary<String, AnyObject>) { (success, profileModel) in
            self.vc?.didEndLoading()
            if success
            {
                guard profileModel?.status == "success" else{
                    return
                }
                self.profileDetails?(profileModel!)
            }
        }
    }
    
    func profileUpdateValidation(firstName: String, lastName: String, email: String, address: String, country: String, state: String, city: String, postalCode: String, mobile: String, isRegister: Bool = false){
        guard firstName != "" else{
            self.updateValidation?(FirstNameError, false)
            return
        }
        guard lastName != "" else{
            self.updateValidation?(LastNameError, false)
            return
        }
        guard email != "" else{
            self.updateValidation?(EmailError, false)
            return
        }
        guard email.isValidEmail() else{
            self.updateValidation?(EmailError, false)
            return
        }
        guard address != "" else{
            self.updateValidation?(AddressError, false)
            return
        }
        guard country != "" else{
            self.updateValidation?(CountryError, false)
            return
        }
        guard state != "" else{
            self.updateValidation?(StateError, false)
            return
        }
        guard city != "" else{
            self.updateValidation?(CityError, false)
            return
        }
        guard postalCode != "" else{
            self.updateValidation?(PostalCodeError, false)
            return
        }
        var params = ["customerid": OTPUserDetails.OTPDetailModel?.customerid ?? "",
                      "firstname": firstName,
                      "lastname": lastName,
                      "email": email,
                      "country": country,
                      "state": state,
                      "city": city,
                      "address": address,
                      "postalcode": postalCode,
                      "mobileno": mobile] as [String : Any]
        
        if isRegister{
            params.removeValue(forKey: "customerid")
            self.vc?.didBeginLoading()
            self.userRegister(params: params)
        }else{
            self.updateProfile(params: params)
        }
    }
    
    func updateProfile(params: [String: Any]){
        self.vc?.didBeginLoading()
        APIRequestManager.sharedInstance.profileUpdate(param:params as Dictionary<String, AnyObject>) { (success, profileModel) in
            self.vc?.didEndLoading()
            if success
            {
                guard profileModel?.status == "success" else{
                    self.updateValidation?(profileModel?.message ?? "", false)
                    return
                }
                self.updateValidation?(profileModel?.message ?? "", true)
            }
        }
    }
    
    func userRegister(params: [String: Any]){
        APIRequestManager.sharedInstance.register(param:params as Dictionary<String, AnyObject>) { (success, registerModel) in
            if success
            {
                guard registerModel?.status == "success" else{
                    self.vc?.didEndLoading()
                    self.updateValidation?(registerModel?.message ?? "", false)
                    return
                }
                
                let address = ["country": params["country"] ?? "",
                               "state": params["state"] ?? "",
                               "city": params["city"] ?? "",
                               "address": params["address"] ?? "",
                               "postalCode": params["postalCode"] ?? "",
                               "streetAndNumber":""] as [String : Any]
                
                let phone = ["mobile": params["mobileno"] ?? ""] as [String : Any]
                
                let meta_data = ["customerid": registerModel?.customerid ?? "",
                                 "picture":"",
                                 "firstname": params["firstname"] ?? "",
                                 "lastname": params["firstname"] ?? "",
                                 "email": params["firstname"] ?? ""] as [String : Any]
                
                let edrvParams = ["customerid": registerModel?.customerid ?? "",
                                  "active":true,
                                  "address":address,
                                  "phone":phone,
                                  "meta_data":meta_data] as [String : Any]
                
                self.userRegisterEdrv(params: edrvParams, customerid: registerModel?.customerid ?? "")
            }
        }
    }
    
    func userRegisterEdrv(params: [String: Any], customerid: String){
        APIRequestManager.sharedInstance.registerUserEdrv(param:params as Dictionary<String, AnyObject>) { (success, edrvModel) in
            if success
            {
                guard edrvModel?.ok ?? false else{
                    self.vc?.didEndLoading()
                    self.updateValidation?(edrvModel?.message ?? "", false)
                    return
                }
                
                let finalParams = ["customerid": customerid, "custinterfaceid": edrvModel?.id ?? ""] as [String : Any]
                self.PostCustConnectIntefaceTOSNAKEV(params: finalParams, customerid: customerid)
            }
        }
    }
    
    func PostCustConnectIntefaceTOSNAKEV(params: [String: Any], customerid: String){
        APIRequestManager.sharedInstance.getCustConnectInterface(param:params as Dictionary<String, AnyObject>) { (success, profileModel) in
            if success
            {
                guard profileModel?.status == "success" else{
                    self.vc?.didEndLoading()
                    self.updateValidation?(profileModel?.message ?? "", false)
                    return
                }
                let params = ["customerid": OTPUserDetails.OTPDetailModel?.customerid ?? ""] as [String : Any]
                self.getProfileRequest(params: params)
            }
        }
    }
}
