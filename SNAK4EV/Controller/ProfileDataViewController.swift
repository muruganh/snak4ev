//
//  ProfileDataViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import SideMenu

class ProfileDataViewController: BaseViewController {
    
    var profileData: [[String: Any]] = []
    var profileDataArr = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewContent: UIView!
    
    var profileModel: ProfileModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        profileData = ["Name": "Anitha", "Mobile Number": "+916756765678", "Email": "Anitha@gmail.com", "Address": "Nehru Street", "City": "Coimbatore", "State": "Tamil Nadu", "Country" : "India", "Postal Code": "642101"]
        
        profileDataArr = ["Mobile Number", "Email", "Address", "City", "State", "Country", "Postal Code"]
        
        //     tableView.dropNavigationViewShadow(shadowColour: UIColor.lightGray.cgColor)
        tableView.isHidden = false
        tableView.sectionHeaderHeight = 80.00
        self.viewContent.dropDarkShadow()
        
        ProfileVM.sharedInstance.getProfile()
        ProfileVM.sharedInstance.profileDetails = {(profileDetails) in
            self.profileModel = profileDetails
            if let name = profileDetails.first_name{
                self.profileData.append(["First Name": name])
            }
            if let lastName = profileDetails.last_name{
                self.profileData.append(["Last Name": lastName])
            }
            if let mobile = profileDetails.mobilenumber{
                self.profileData.append(["Mobile Number": mobile])
            }
            if let email = profileDetails.emailid{
                self.profileData.append(["Email": email])
            }
            if let address = profileDetails.address{
                self.profileData.append(["Address": address])
            }
            if let city = profileDetails.cityid{
                self.profileData.append(["City": city])
            }
            if let state = profileDetails.stateid{
                self.profileData.append(["State": state])
            }
            if let country = profileDetails.countryid{
                self.profileData.append(["Country": country])
            }
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
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
