//
//  HeaderView.swift
//  UIDesign
//
//  Created by Apple on 19/03/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

@IBDesignable class HeaderView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        let bundle = Bundle(for: HeaderView.self)
        let contentView = bundle.loadNibNamed("HeaderView", owner: self, options: nil)?[0] as! UIView
        return contentView
    }
}

