//
//  WalletViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import Razorpay

struct paymentDetail {
    
    var phone:String
    var email:String
    var currency:String = "INR"
    var amount:Int
    var image:String
    var description:String
    var name:String
    var theme:String

    init?(amount : Int) {
    
        self.init(phone: "9489037946", email: "syed_sulaiman@dlightech.in",currency: "INR" ,amount: amount,image: "https://cdn4.vectorstock.com/i/1000x1000/60/68/money-payment-logo-vector-24006068.jpg", description: "Charging",  name: "SNAK4EV", theme: "#FF0000")
        
    }
                               
    init?(phone:String, email:String,currency: String, amount: Int,image :String = "", description: String, name:String = "", theme:String) {
        self.phone = phone
        self.email = email
        self.currency = currency
        self.amount = amount
        self.image = image
        self.description = description
        self.name = name
        self.theme = theme
    }


    
    func getpaymentDetailOptions() -> [String:Any] {
        let options: [String:Any] = [
            "image": self.image,
            "amount" : self.amount * 100,
            "currency": self.currency,
            "name":self.name,
           "description":self.description,
           "theme": [
                "color": self.theme
            ]
        ]
        return options
    }
}

class WalletViewController: UIViewController,RazorpayPaymentCompletionProtocol{
    
func onPaymentError(_ code: Int32, description str: String) {
    print("error: ", code, str)
    let alert = UIAlertController(title: "failure", message: str, preferredStyle : .alert)
    let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
}

func onPaymentSuccess(_ payment_id: String) {
    print("success: ", payment_id)
    let alert = UIAlertController(title: "success", message: "payment Id \(payment_id)", preferredStyle : .alert)
    let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
}

    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var lblMoney: UILabel!
    
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var btn200: UIButton!
    @IBOutlet weak var btn300: UIButton!
    @IBOutlet weak var btn400: UIButton!
    @IBOutlet weak var btn500: UIButton!
    @IBOutlet weak var btn1000: UIButton!
    @IBOutlet weak var btn2000: UIButton!
    var selectedAmount : Int = 0
    @IBAction func amountbtnClicked(_ sender: UIButton ){
        selectedAmount = sender.tag
        selectBtnColor(button: sender)
        
    }
    var razorpay: RazorpayCheckout!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        btn200.tag = 200
        btn300.tag = 300
        btn400.tag = 400
        btn500.tag = 500
        btn1000.tag = 1000
        btn2000.tag = 2000
       
        razorpay = RazorpayCheckout.initWithKey("rzp_test_UNIYnViM67Qrcr", andDelegate: self)
         headerView.lblTitle.text = "WALLET"
   
        
        walletView.dropNavigationViewShadow(shadowColour: UIColor.lightGray.cgColor)
        
    }
    internal func showPaymentForm(paymentdetail:paymentDetail){
        let options: [String:Any] =  paymentdetail.getpaymentDetailOptions()
        razorpay.open(options)
    }
    
     func selectBtnColor(button: UIButton) {
        let btnTags = [btn200,btn300,btn400,btn500,btn1000,btn2000]
        
        for btn in btnTags {
            if button.tag == btn?.tag {
                
                btn?.backgroundColor = .red
            } else {
               
                btn?.backgroundColor = .systemGray5
            }
        }
    }
    
    
    @IBAction func addMoney(_ sender: Any) {
        greyView.isHidden = false

    }
    
    @IBAction func addSelectAmount(_ sender: Any) {
       
        if let paymentDetails = paymentDetail(amount: selectedAmount){
            self.showPaymentForm(paymentdetail: paymentDetails)
        }
            
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        greyView.isHidden = true
    }
}

extension UIView {
    func dropNavigationViewShadow(shadowColour: CGColor = UIColor.darkGray.cgColor) {
        layer.cornerRadius = 10
        layer.shadowColor = shadowColour
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
}
