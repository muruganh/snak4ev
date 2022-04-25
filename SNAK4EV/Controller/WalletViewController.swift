//
//  WalletViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var lblMoney: UILabel!
    
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var greyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         headerView.lblTitle.text = "WALLET"
        
        walletView.dropNavigationViewShadow(shadowColour: UIColor.lightGray.cgColor)
            
    }

    
    @IBAction func addMoney(_ sender: Any) {
        greyView.isHidden = false
    }
    
    @IBAction func addSelectAmount(_ sender: Any) {
        
    }
    @IBAction func closeBtn(_ sender: Any) {
        greyView.isHidden = true
    }
}

extension UIView {
    func dropNavigationViewShadow(shadowColour: CGColor = UIColor.darkGray.cgColor) {
        layer.cornerRadius = 10
        layer.shadowColor = shadowColour
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
}
