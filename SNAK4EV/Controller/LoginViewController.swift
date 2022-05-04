//
//  loginViewController.swift
//  SNAK4EV
//
//  Created by Sulaiman on 30/03/22.
//

import UIKit

class LoginViewController: BaseViewController {
    @IBOutlet weak var imgLogo :UIImageView!
    @IBOutlet weak var lblWelcome :UILabel!
    @IBOutlet weak var lblDescription :UILabel!
    @IBOutlet weak var txtPhoneNumber :UITextField?
    @IBOutlet weak var btnLogin :UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 7
        btnLogin.layer.masksToBounds =  true
        txtPhoneNumber?.layer.cornerRadius = 7
        txtPhoneNumber?.layer.masksToBounds
        =  true
// Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnOTPGenerate(_ sender: UIButton){
        LoginVM.sharedInstance.loginRequestClick(mobile: self.txtPhoneNumber?.text ?? "", vc: self)
        LoginVM.sharedInstance.loginSuccess = {(otpGenerateModel) in
            let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            vc.mobile = self.txtPhoneNumber?.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        LoginVM.sharedInstance.loginValidation = {(msg) in
            self.toast(message: msg)
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

extension LoginViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool
    {
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
