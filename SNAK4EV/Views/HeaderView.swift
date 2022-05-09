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
    @IBOutlet weak var imgBack: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

