//
//  connectorSelectionViewController.swift
//  SNAK4EV
//
//  Created by Sulaiman on 21/04/22.
//

import UIKit

class ConnectorSelectionViewController: BaseViewController {
    
    @IBOutlet var tblView: UITableView!
    @IBOutlet var lblNorecords: UILabel!
    var qrCode: String = ""
    var chargerList: [ChargerLocationModel]?{
        didSet{
            self.tblView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView?.lblTitle.text = "CONNECTOR SELECTION"
        let nib = UINib(nibName: "ConnectorTableViewCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "ConnectorTableViewCell")
        self.getChargerList()
    }
    
    func getChargerList(){
        let params = ["qrcode": qrCode, "companyid":""] as [String : Any]
        ChargerVM.sharedInstance.getChargerDetails(params: params)
        ChargerVM.sharedInstance.chargerDetails = {(msg, list) in
            if msg == ""{
                self.chargerList = list
                self.tblView.isHidden = false
            }else{
                self.toast(message: msg)
                self.tblView.isHidden = true
            }
            self.lblNorecords.isHidden = !self.tblView.isHidden
        }
    }
}

extension ConnectorSelectionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chargerList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectorTableViewCell") as! ConnectorTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
