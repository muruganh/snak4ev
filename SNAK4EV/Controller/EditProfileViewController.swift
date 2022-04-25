//
//  EditProfileViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnBack.layer.borderWidth = 1.0
        btnBack.layer.borderColor = UIColor.lightGray.cgColor
        
        headerView.lblTitle.text = "MY PROFILE"
        
        removeBoder(textField: txtFirstName)
        removeBoder(textField: txtLastName)
        removeBoder(textField: txtCity)
        removeBoder(textField: txtAddress)
        removeBoder(textField: txtEmail)
        removeBoder(textField: txtState)
        removeBoder(textField: txtCountry)
        removeBoder(textField: txtPostalCode)
    }
    
    func removeBoder(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 7.0
        textField.layer.masksToBounds = true
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
    
    }
}
