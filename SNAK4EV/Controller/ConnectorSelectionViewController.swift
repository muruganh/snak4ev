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
    
    var connectorsList: [ConnectorsList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        Globals.shared.existingIndex = 10
        navigationBar.lblTitle.text = "CONNECTOR SELECTION"
        let nib = UINib(nibName: "ConnectorTableViewCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "ConnectorTableViewCell")
        if self.connectorsList.count == 0{
            self.getChargerList()
        }else{
            DispatchQueue.main.async {
                self.tblView.reloadData()
                self.tblView.isHidden = false
                self.lblNorecords.isHidden = !self.tblView.isHidden
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationBar.imgBack.image = UIImage.init(named: "back")
        navigationBar.btnBack.addTarget(self, action: #selector(btnMenu(_:)), for: .touchUpInside)
    }
    
    @IBAction override func btnMenu(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getChargerList(){
        let params = ["qrcode": qrCode, "companyid":""] as [String : Any]
        ChargerVM.sharedInstance.getChargerDetails(params: params)
        ChargerVM.sharedInstance.chargerDetails = {(msg, list) in
            if msg == ""{
                self.chargerList = list
                self.tblView.isHidden = false
            }else{
                self.lblNorecords.text = msg
                self.tblView.isHidden = true
            }
            self.lblNorecords.isHidden = !self.tblView.isHidden
        }
    }
}

extension ConnectorSelectionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.connectorsList.count != 0 ? self.connectorsList.count : (self.chargerList?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectorTableViewCell") as! ConnectorTableViewCell
        if self.connectorsList.count != 0{
            cell.connectorDetails = self.connectorsList[indexPath.row]
        }else{
            cell.chargeStationDetails = self.chargerList?[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
