//
//  MenuViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit

class MenuViewController: BaseViewController {
    
    var menuList = [ "", "Home", "QR Scan", "My Account", "Update Wallet", "Charging Monitoring", "About", "Sign Out"  ]
    var imgList = [ "", "home", "scanner", "account", "wallet", "lighting", "info", "logout"  ]
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath) as! SectionHeaderCell
            if let name = UserDetails.UserDetailModel?.first_name as? String{
                cell.lblTitle.text = name.capitalized
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
            cell.lblTitle.text = menuList[indexPath.row]
            cell.imgMenu.image = UIImage.init(named: imgList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140.0
        } else {
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isOpenNewVc(index: indexPath.row){
            if(indexPath.row == 1){
                let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 2){
                let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "ScanQRViewController") as! ScanQRViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 3){
                let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "ProfileDataViewController") as! ProfileDataViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 4){
                let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 5){
                let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "ChargingMonitoringViewController") as! ChargingMonitoringViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 6){
                let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 7{
                self.logOut()
            }
            
        }
        Globals.shared.existingIndex = indexPath.row == 6 ? 0 : indexPath.row
    }
    
    
    func isOpenNewVc(index: Int)-> Bool{
        if index != Globals.shared.existingIndex{
            return true
        }
        return false
    }
}

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}

class SectionHeaderCell: UITableViewCell {
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}
