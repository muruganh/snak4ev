//
//  connectorHeaderView.swift
//  SNAK4EV
//
//  Created by Sulaiman on 21/04/22.
//

import UIKit

class ConnectorTableViewCell: UITableViewCell {
    
    var view: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var imgCharge: UIImageView!
    @IBOutlet weak var imgAmount: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCharge: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var footerView: UIView!
    
    var chargeStationDetails: ChargerLocationModel?{
        didSet{
            self.setObject()
        }
    }
    
    var connectorDetails: ConnectorsList?{
        didSet{
            self.setConnectorObject()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgType.layer.cornerRadius = imgType.frame.size.height/2
        imgCharge.layer.cornerRadius = imgCharge.frame.size.height/2
        imgAmount.layer.cornerRadius = imgAmount.frame.size.height/2
        
    }
    
//    func viewSetup() {
//        view = loadViewFromNib()
//        view.frame = bounds
//        addSubview(view)
//    }
//
//    func loadViewFromNib() -> UIView {
//        let bundle = Bundle(for: connectorHeaderView.self)
//        let contentView = bundle.loadNibNamed("connectorHeaderView", owner: self, options: nil)?[0] as! UIView
//        return contentView
//    }
    
    func setObject(){
        self.lblType.text = self.chargeStationDetails?.connectortype ?? ""
        self.lblAmount.text = self.chargeStationDetails?.ratecur ?? ""
        self.lblCharge.text = self.chargeStationDetails?.chargeronline ?? ""
    }
    
    func setConnectorObject(){
        self.lblType.text = self.connectorDetails?.type ?? ""
        self.lblAmount.text = (self.connectorDetails?.rate?.name ?? "").lowercased().replacingOccurrences(of: "rs", with: "")
        self.lblCharge.text = "\(self.connectorDetails?.power ?? 0)kW"
    }
}





