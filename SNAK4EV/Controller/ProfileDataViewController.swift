//
//  ProfileDataViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import SideMenu

class ProfileDataViewController: BaseViewController {
    
    var profileData = [String:Any]()
    var profileDataArr = [String]()

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        headerView.lblTitle.text = "MY PROFILE"
        
        profileData = ["Name": "Anitha", "Mobile Number": "+916756765678", "Email": "Anitha@gmail.com", "Address": "Nehru Street", "City": "Coimbatore", "State": "Tamil Nadu", "Country" : "India", "Postal Code": "642101"]
        
        profileDataArr = ["Mobile Number", "Email", "Address", "City", "State", "Country", "Postal Code"]
        
        //     tableView.dropNavigationViewShadow(shadowColour: UIColor.lightGray.cgColor)
        tableView.isHidden = false
        tableView.sectionHeaderHeight = 100.00
    }
    
    @IBAction func btnMenu(_ sender: UIButton){
        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.menuWidth = 320
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
}

extension ProfileDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileDataArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableCell(withIdentifier: "EditHeaderTableViewCell")! as! EditHeaderTableViewCell
//        view.lblName.text = profileData["Name"] as! String
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 170.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
//        cell.lblTitle.text = profileDataArr[indexPath.row]
//        cell.lblValue.text = profileData[profileDataArr[indexPath.row]] as! String
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableCell(withIdentifier: "EditFooterCell")! as! EditFooterCell
//        view.btnEdit.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    @objc func editProfile(sender: AnyObject) {
        
    }
}
