//
//  popUpView.swift
//  SNAK4EV
//
//  Created by Sulaiman on 21/04/22.
//

import UIKit

class popUpView: UIView {
    var view: UIView!
    
    @IBOutlet weak var lblAddress: UILabel!
@IBOutlet weak var btnNAvigate: UIButton!
@IBOutlet weak var btnSelection: UIButton!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgCharge: UIImageView!
    @IBOutlet weak var lblCharge: UILabel!
    @IBOutlet weak var imgAmount: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var footerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnNAvigate.layer.cornerRadius = 5
        btnSelection.layer.cornerRadius = 5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setObject(locationModel: ChargeStationLocationModel, details: ChargeStationList){
        self.lblAddress.text = self.getAddress(locationModel: locationModel)
        if let type = details.connectors?[0].type as? String{
            self.lblType.text = type
        }
        if let power = details.connectors?[0].power as? Int{
            self.lblCharge.text = "\(power)" + "kW"
        }
        if let amount = details.connectors?[0].rate?.name as? String{
            self.lblAmount.text = amount.replacingOccurrences(of: "rs", with: "")
        }
        if let status = details.connectors?[0].status as? String{
            self.lblAvailable.text = status
        }
    }
    
    func getAddress(locationModel: ChargeStationLocationModel)-> String{
        let street = locationModel.result?.address?.streetAndNumber ?? ""
        let city = locationModel.result?.address?.city ?? ""
        let state = locationModel.result?.address?.state ?? "" + ", "
        let postalcode = locationModel.result?.address?.postalCode ?? ""
        return (street + ", " + city + ", " + state  + ", " + postalcode)
    }
}


