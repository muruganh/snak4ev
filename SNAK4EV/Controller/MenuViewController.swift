//
//  MenuViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit

class MenuViewController: BaseViewController {
    
    var menuList = ["", "QR Scan", "My Account", "Update Wallet", "Charging Monitoring", "About", "Sign Out"]
   var menulistIcon = UIImage(named: "menu1")

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
            cell.lblTitle.text = menuList[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 170.0
        } else {
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}
