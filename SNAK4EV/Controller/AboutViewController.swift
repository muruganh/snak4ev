//
//  AboutViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var headerView: HeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.lblTitle.text = "ABOUT"
        
    }
    
    @IBAction func checkUpdates(_ sender: Any) {
   
    }
}
