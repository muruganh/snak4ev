//
//  RegisterViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 12/05/22.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var lblMobile: UILabel!
    var mobile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationBar.imgBack.image = UIImage.init(named: "back")
        navigationBar.btnBack.addTarget(self, action: #selector(btnMenu(_:)), for: .touchUpInside)
    }
    
    @IBAction override func btnMenu(_ sender: UIButton) {
        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        ProfileVM.sharedInstance.profileUpdateValidation(firstName: self.txtFirstName.text ?? "", lastName: self.txtLastName.text ?? "", email: self.txtEmail.text ?? "", address: self.txtAddress.text ?? "", country: self.txtCountry.text ?? "", state: self.txtState.text ?? "", city: self.txtCity.text ?? "", postalCode: self.txtPostalCode.text ?? "", mobile: mobile)
        ProfileVM.sharedInstance.updateValidation = {(msg, success) in
            if success{
                print(msg)
            }else{
                self.toast(message: msg)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
