//
//  ChargerVM.swift
//  SNAK4EV
//
//  Created by Apple  on 04/05/22.
//

import Foundation

class ChargerVM: NSObject{
    
    static let sharedInstance = ChargerVM()
    
    var chargerDetails: ((String, [ChargerLocationModel]) -> Void)?
    
    func getChargerDetails(params: [String : Any]){
        APIRequestManager.sharedInstance.getChargerDetails(param:params as Dictionary<String, AnyObject>) { (success, chargerModel) in
            if success
            {
                guard chargerModel?.status == "success" else{
                    self.chargerDetails?(chargerModel?.message ?? "", chargerModel?.location ?? [])
                    return
                }
            }
            self.chargerDetails?("", chargerModel?.location ?? [])
        }
    }
    
}
