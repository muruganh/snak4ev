//
//  gifView.swift
//  SNAK4EV
//
//  Created by Sulaiman on 21/04/22.
//

import UIKit

class gifView: UIView {
    var view: UIView!
    @IBOutlet weak var imgGif : UIImageView!
    @IBOutlet weak var btnCancel : UIButton!
    @IBOutlet weak var imgCancel : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgGif.layer.cornerRadius = 15
        imgCancel.layer.cornerRadius = imgCancel.frame.size.height/2
        
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
        let bundle = Bundle(for: gifView.self)
        let contentView = bundle.loadNibNamed("gifView", owner: self, options: nil)?[0] as! UIView
        return contentView
    }
    
    
    
}





