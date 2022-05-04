//
//  PaymentVM.swift
//  SNAK4EV
//
//  Created by Apple  on 29/04/22.
//

import UIKit

class WalletVM: NSObject {
    
    static let sharedInstance = WalletVM()

    var updateWalletStatus: ((Bool, String) -> Void)?
    var loadWalletAmount: ((Bool, String) -> Void)?
    
    func updateWalletRequest(param: [String : Any]){
        APIRequestManager.sharedInstance.updateWallet(param:param as Dictionary<String, AnyObject>) { (success, walletModel) in
            if success
            {
                guard walletModel?.status == "success" else{
                    self.updateWalletStatus?(false, walletModel?.message ?? "")
                    return
                }
                self.updateWalletStatus?(true, walletModel?.message ?? "")
            }
        }
    }
    
    
    func getWalletRequest(param: [String : Any]){
        APIRequestManager.sharedInstance.getWalletBalance(param:param as Dictionary<String, AnyObject>) { (success, walletModel) in
            if success
            {
                guard walletModel?.status == "success" else{
                    self.loadWalletAmount?(false, walletModel?.message ?? "")
                    return
                }
                self.loadWalletAmount?(true, walletModel?.walletbal ?? "")
            }
        }
    }
    
}
