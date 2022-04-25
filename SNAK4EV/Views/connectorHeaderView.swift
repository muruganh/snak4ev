//
//  connectorHeaderView.swift
//  SNAK4EV
//
//  Created by Sulaiman on 21/04/22.
//

import UIKit

class connectorHeaderView: UIView {
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
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgType.layer.cornerRadius = imgType.frame.size.height/2
        imgCharge.layer.cornerRadius = imgCharge.frame.size.height/2
        imgAmount.layer.cornerRadius = imgAmount.frame.size.height/2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    func viewSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: connectorHeaderView.self)
        let contentView = bundle.loadNibNamed("connectorHeaderView", owner: self, options: nil)?[0] as! UIView
        return contentView
    }
}





