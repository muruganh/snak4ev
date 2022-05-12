//
//  OTPViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 27/04/22.
//

import UIKit

class OTPViewController: BaseViewController {

    @IBOutlet weak var txtOTP: UITextField!
    @IBOutlet weak var lblOTPMin: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnResendTop: NSLayoutConstraint!
    var timer: Timer?
    var tmpTotalTime = 10
    var totalTime = 0
    var mobile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.txtOTP.becomeFirstResponder()
        self.lblDesc.text = "Enter the 6 digit code we sent to you at +91 " + mobile
        self.totalTime = tmpTotalTime
        self.btnResendTop.constant = 60
        if Display.typeIsLike == .iphoneX{
            self.txtOTP.setLeftPadding(24.0)
        }else{
            self.txtOTP.setLeftPadding(16.0)
        }
        self.txtOTP.addTarget(self, action: #selector(textFieldEdidtingDidChange(_ :)), for: UIControl.Event.editingChanged)
        self.startOtpTimer()
        // Do any additional setup after loading the view.
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

//MARK:- UITextFieldDelegate
extension OTPViewController: UITextFieldDelegate{
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        return WGTextField.isValidOTP(otpStr: text)
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool
    {
        let maxLength = 6
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc func textFieldEdidtingDidChange(_ textField :UITextField) {
        var space = 40.0
        if Display.typeIsLike == .iphoneX{
            space = 44.0
        }
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(space), range: NSRange(location: 0, length: attributedString.length))
        textField.attributedText = attributedString
    }
    
}

extension OTPViewController{
    func startOtpTimer() {
        self.lblOTPMin.isHidden = false
        self.btnResend.isEnabled = false
        self.btnResend.alpha = 0.3
        self.totalTime = self.tmpTotalTime
        self.btnResendTop.constant = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(self.lblOTPMin != nil){
            self.lblOTPMin.text = self.timeFormatted(self.totalTime)
        }
        if totalTime != 0 {
            totalTime -= 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                self.lblOTPMin.isHidden = true
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        if(minutes == 0 && seconds == 0){
            if(self.btnResend != nil && self.lblOTPMin != nil){
                self.btnResend.alpha = 1.0
                self.btnResend.isEnabled = true
                self.btnResendTop.constant = 25
            }
        }
        return String(format: "%02d:%02d", minutes, seconds)
        //return String(format: "%02d", seconds)
    }
    
    @IBAction func btnResend(_ sender: Any) {
        LoginVM.sharedInstance.loginRequestClick(mobile: mobile, vc: self)
        LoginVM.sharedInstance.loginSuccess = {(otpGenerateModel) in
            self.startOtpTimer()
        }
    }
    
    func otpAuthenticate(){
        let params = ["mobileno": self.mobile, "otpauthcode": self.txtOTP.text ?? ""] as [String : Any]
        LoginVM.sharedInstance.otpAuthenticateRequest(param: params)
        LoginVM.sharedInstance.otpSuccess = {(otpModel) in
            LoginVM.sharedInstance.tokenRequest()
            LoginVM.sharedInstance.tokenSuccess = {(apiToken)in
                if otpModel.iscustomer == "0"{
                    let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                    vc.mobile = self.mobile
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    ProfileVM.sharedInstance.vc = self
                    ProfileVM.sharedInstance.getProfile()
                    ProfileVM.sharedInstance.profileDetails = {(profileDetails) in
                        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        LoginVM.sharedInstance.loginValidation = {(msg) in
            self.toast(message: msg)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.txtOTP.text?.count == 6{
            self.otpAuthenticate()
        }
    }
}
