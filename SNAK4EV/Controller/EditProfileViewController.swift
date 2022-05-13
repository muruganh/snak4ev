//
//  EditProfileViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import DropDown

class EditProfileViewController: BaseViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var viewTerms: UIView!
    @IBOutlet weak var btnUpdateTopConstraint: NSLayoutConstraint!
    var delegate: ProfileUpdateDelegate?
    
    @IBOutlet weak var btnBack: UIButton!
    var profileModel: ProfileModel?
    
    let dropDown = DropDown()
    
    var countries: [CountryModel]?
    
    var countryId: Int?
    
    var stateId: Int?
    
    var cityId: Int?
    
    var isRegister = false
    
    var mobile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        btnBack.layer.borderWidth = 1.0
//        btnBack.layer.borderColor = UIColor.lightGray.cgColor
        
        removeBoder(textField: txtFirstName)
        removeBoder(textField: txtLastName)
        removeBoder(textField: txtCity)
        removeBoder(textField: txtAddress)
        removeBoder(textField: txtEmail)
        removeBoder(textField: txtState)
        removeBoder(textField: txtCountry)
        removeBoder(textField: txtPostalCode)
        
        self.getCountryJson()
        self.setPadding()
        
        
        if isRegister{
            self.lblMobile.text = self.mobile
            btnUpdate.setTitle("Register", for: .normal)
        }else{
            self.btnUpdateTopConstraint.constant = 24
            self.viewTerms.isHidden = true
            self.setUserDetails()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationBar.lblTitle.text = isRegister ? "Create Account" : "Edit Profile"
        navigationBar.imgBack.image = UIImage.init(named: "back")
        navigationBar.btnBack.addTarget(self, action: #selector(btnMenu(_:)), for: .touchUpInside)
    }
    
    @IBAction override func btnMenu(_ sender: UIButton){
        if isRegister{
            self.logOut()
        }else{
            self.delegate?.setUserDetails(profileDetails: self.profileModel!)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnCheckbox(_ sender: UIButton){
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    func setUserDetails(){
        
        if let first_name = self.profileModel?.first_name{
            self.txtFirstName?.text = first_name
        }
        if let lastName = self.profileModel?.last_name{
            self.txtLastName?.text = lastName
        }
        if let mobile = self.profileModel?.mobilenumber{
            self.lblMobile?.text = "+91" + mobile
        }
        if let email = self.profileModel?.emailid{
            self.txtEmail?.text = email
        }
        if let address = self.profileModel?.address{
            self.txtAddress?.text = address
        }
        if let city = self.profileModel?.cityid{
            self.txtCity?.text = city
        }
        if let state = self.profileModel?.stateid{
            self.txtState?.text = state
        }
        if let country = self.profileModel?.countryid{
            self.txtCountry?.text = country
        }
        if let postalCode = self.profileModel?.postal_code{
            self.txtPostalCode?.text = postalCode
        }
    }
    
    func setPadding(){
        self.txtFirstName.setLeftPadding(8.0)
        self.txtLastName.setLeftPadding(8.0)
        self.txtEmail.setLeftPadding(8.0)
        self.txtAddress.setLeftPadding(8.0)
        self.txtCountry.setLeftPadding(8.0)
        self.txtState.setLeftPadding(8.0)
        self.txtCity.setLeftPadding(8.0)
        self.txtPostalCode.setLeftPadding(8.0)
    }
    
    func getCountryJson(){
        APIRequestManager().getCountryList(){ (countryModel) in
            self.countries = countryModel?.Countries
        }
    }
    
    func getCountryList(){
        var country:[String] = []
        for obj in self.countries ?? []{
            country.append(obj.CountryName ?? "")
        }
        self.dropDown.dataSource = country
        self.dropDown.direction = .bottom
        self.dropDown.anchorView = self.txtCountry
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtCountry.text = item
            self.countryId = index
            self.stateId = nil
            self.cityId = nil
            self.txtState.text = ""
            self.txtCity.text = ""
            self.dropDown.hide()
        }
        self.dropDown.show()
    }
    
    func getStateList(){
        var states:[String] = []
        let stateObjList = self.countries?[self.countryId ?? 0].States
        for obj in stateObjList ?? []{
            states.append(obj.StateName ?? "")
        }
        self.dropDown.dataSource = states
        self.dropDown.direction = .bottom
        self.dropDown.anchorView = self.txtState
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtState.text = item
            self.txtCity.text = ""
            self.stateId = index
            self.cityId = nil
            self.dropDown.hide()
        }
        self.dropDown.show()
    }
    
    func getCityList(){
        let cities = self.countries?[self.countryId ?? 0].States?[self.stateId ?? 0].Cities ?? []
        self.dropDown.dataSource = cities
        self.dropDown.direction = .bottom
        self.dropDown.anchorView = self.txtCity
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtCity.text = item
            self.cityId = index
            self.dropDown.hide()
        }
        self.dropDown.show()
    }
    
    func removeBoder(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 7.0
        textField.layer.masksToBounds = true
    }
    
    @IBAction func updateBtn(_ sender: UIButton) {
        if isRegister{
            self.registerRequest()
        }else{
            self.updateRequest()
        }
    }
    
    func registerRequest(){
        let terms = self.btnCheckbox.isSelected
        ProfileVM.sharedInstance.profileUpdateValidation(firstName: self.txtFirstName.text ?? "", lastName: self.txtLastName.text ?? "", email: self.txtEmail.text ?? "", address: self.txtAddress.text ?? "", country: self.txtCountry.text ?? "", state: self.txtState.text ?? "", city: self.txtCity.text ?? "", postalCode: self.txtPostalCode.text ?? "", mobile: mobile, isRegister: true, isTerms: terms, vc: self)
        ProfileVM.sharedInstance.updateValidation = {(msg, success) in
            if !success{
                self.didEndLoading()
                self.toast(message: msg)
            }
        }
        ProfileVM.sharedInstance.profileDetails = {(profileDetails) in
            self.didEndLoading()
            let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateRequest(){
        ProfileVM.sharedInstance.profileUpdateValidation(firstName: self.txtFirstName.text ?? "", lastName: self.txtLastName.text ?? "", email: self.txtEmail.text ?? "", address: self.txtAddress.text ?? "", country: self.txtCountry.text ?? "", state: self.txtState.text ?? "", city: self.txtCity.text ?? "", postalCode: self.txtPostalCode.text ?? "", mobile: self.profileModel?.mobilenumber ?? "", vc: self)
        ProfileVM.sharedInstance.vc = self
        ProfileVM.sharedInstance.updateValidation = {(msg, success) in
            ProfileVM.sharedInstance.getProfile()
            ProfileVM.sharedInstance.profileDetails = {(profileDetails) in
                self.profileModel = profileDetails
                self.toast(message: msg)
            }
        }
    }
    
    
    @IBAction func btnCountrySelection(_ sender: UIButton) {
        if sender.tag == 1{
            self.getCountryList()
        }else if sender.tag == 2{
            if !(txtCountry.text?.isEmpty ?? false){
                self.getStateList()
            }
        }else{
            if !(txtState.text?.isEmpty ?? false){
                self.getCityList()
            }
        }
    }
    
    @IBAction func btnTerms(_ sender: UIButton) {
        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "TermsConditionViewController") as! TermsConditionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
