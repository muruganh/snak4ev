//
//  loginViewController.swift
//  SNAK4EV
//
//  Created by Sulaiman on 30/03/22.
//

import UIKit

class loginViewController: UIViewController {
    @IBOutlet weak var imgLogo :UIImageView!
    @IBOutlet weak var lblWelcome :UILabel!
    @IBOutlet weak var lblDescription :UILabel!
    @IBOutlet weak var txtPhoneNumber :UITextField!
    @IBOutlet weak var btnLogin :UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 7
        btnLogin.layer.masksToBounds =  true
        txtPhoneNumber.layer.cornerRadius = 7
        txtPhoneNumber.layer.masksToBounds
        =  true
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
