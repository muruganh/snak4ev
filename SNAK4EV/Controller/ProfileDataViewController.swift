//
//  ProfileDataViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import SideMenu

class ProfileDataViewController: BaseViewController, ProfileUpdateDelegate {
    
    var profileData: [[String: Any]] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewContent: UIView!
    var profileModel: ProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
    }
    
    func initialLoad(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.isHidden = false
        tableView.sectionHeaderHeight = 80.00
        self.viewContent.dropDarkShadow()
        ProfileVM.sharedInstance.getProfile()
        ProfileVM.sharedInstance.profileDetails = {(profileDetails) in
            self.setUserDetails(profileDetails: profileDetails)
        }
    }
    
    func setUserDetails(profileDetails: ProfileModel){
        self.profileModel = profileDetails
        self.profileData.removeAll()
        if let name = self.profileModel?.first_name{
            self.profileData.append(["First Name": name])
        }
        if let lastName = self.profileModel?.last_name{
            self.profileData.append(["Last Name": lastName])
        }
        if let mobile = self.profileModel?.mobilenumber{
            self.profileData.append(["Mobile Number": mobile])
        }
        if let email = self.profileModel?.emailid{
            self.profileData.append(["Email": email])
        }
        if let address = self.profileModel?.address{
            self.profileData.append(["Address": address])
        }
        if let city = self.profileModel?.cityid{
            self.profileData.append(["City": city])
        }
        if let state = self.profileModel?.stateid{
            self.profileData.append(["State": state])
        }
        if let country = self.profileModel?.countryid{
            self.profileData.append(["Country": country])
        }
        self.tableView.reloadData()
        self.tableView.isHidden = false
        self.viewContent.isHidden = false
    }
}

extension ProfileDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "EditHeaderTableViewCell")! as! EditHeaderTableViewCell
        view.img.dropDarkShadow()
        if profileData.count != 0{
            let key = profileData[0].first?.key ?? ""
            view.lblName.text = profileData[0][key] as? String
        }
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 170.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
        let key = profileData[indexPath.row].first?.key ?? ""
        cell.lblTitle.text = key
        cell.lblValue.text = profileData[indexPath.row][key] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "EditFooterCell")! as! EditFooterCell
        view.btnEdit.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    @objc func editProfile(sender: AnyObject) {
        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        vc.profileModel = profileModel
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class EditHeaderTableViewCell: UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
}

class EditProfileTableViewCell: UITableViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
}

class EditFooterCell: UITableViewCell{
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblValue: UILabel!
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
