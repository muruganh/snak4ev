//
//  Protocols.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import Foundation
import UIKit

protocol ImageUpdateDelegate {
    func updateImage(isSuccess: Bool, imageUrl: String)
}

protocol LoaderStartStopDelegate: AnyObject {
    func isStartLoading(isload: Bool)
}


protocol ProfileUpdateDelegate: AnyObject {
    func setUserDetails(profileDetails: ProfileModel)
}
