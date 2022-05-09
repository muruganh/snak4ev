//
//  ChargingMonitoringViewController.swift
//  SNAK4EV
//
//  Created by Sulaiman on 12/04/22.
//

import UIKit

class ChargingMonitoringViewController: BaseViewController {
    @IBOutlet weak var lblData : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.lblTitle.text = "CHARGE MONITORING"
        //lblData.isHidden = true
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
