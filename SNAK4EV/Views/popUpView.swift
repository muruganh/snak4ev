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
    @IBOutlet weak var stackView: UIStackView!
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
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnNAvigate.layer.cornerRadius = 5
        btnSelection.layer.cornerRadius = 5
        imgType.layer.cornerRadius = imgType.frame.size.height/2
        imgCharge.layer.cornerRadius = imgType.frame.size.height/2
        imgAmount.layer.cornerRadius = imgType.frame.size.height/2
        
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
        let bundle = Bundle(for: popUpView.self)
        let contentView = bundle.loadNibNamed("popUpView", owner: self, options: nil)?[0] as! UIView
        return contentView
    }
}


