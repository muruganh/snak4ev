//
//  Globals.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import Foundation
import JTMaterialSpinner
import UIKit

class Globals: NSObject{
    
    static let shared = Globals()
    var spinnerView = JTMaterialSpinner()
    var shareViewController: BaseViewController!
    var transition: MaterialTransition?
    var fcmToken: String = ""
    var mobile: String = ""
    var dontShowmessage: Bool = false
    var isloaderWithinButton: Bool = false
    var videoPath: URL!
    var message = ""
    
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    func hexColor(colorCode: String)-> UIColor{
        return UIColor.init(colorCode: colorCode)!
    }
    
    func checkNull(inputStr: String!)-> String{
        if(inputStr == nil){
            return ""
        }
        return inputStr
    }
    
    func getCurrentDateTimeToImageUpload()->String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        var dateString = dateFormatter.string(from: date)
        dateString = dateString.replacingOccurrences(of: " ", with: "")
        return dateString
    }
}
