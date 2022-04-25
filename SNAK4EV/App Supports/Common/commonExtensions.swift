//
//  commonExtensions.swift
//  BLT
//
//  Created by Murugan on 08/03/21.
//

import Foundation
import UIKit
import CommonCrypto
import GoogleMaps

public enum AlertButtons: String
{
    case Cancel
    case Ok
    var description: String {
        switch self {
        case .Cancel:
            return "Cancel"
        case .Ok:
            return "Ok"
        }
    }
}

typealias ToastAlertCompletionHandler = (Bool) -> Void

var currentScrollView : UIScrollView?

protocol AlertableView {
    typealias CompletionHandler = ((_ button:AlertButtons) -> Void)
    
    func displayAlert(with title: String, message: String, style: UIAlertController.Style, actions: [AlertButtons]?, completion: CompletionHandler?)
}

extension String {
    func toDouble() -> Double {
        if let double = Double(self) {
            return double
        }
        return 0.0
    }
}
extension UITextField {
    @IBInspectable var needBottomBorder : Bool {
        get{
            return true
        }
        set {
            if newValue {
                //commonFile.sharedInstance.layerDrawForView(view: self, position: .LAYER_BOTTOM, color: UIColor.black, layerThickness: 0.6)
            }
            else {
                self.layer.sublayers?.removeAll()
            }
        }
    }
    func autoEnableKey() {
        self.enablesReturnKeyAutomatically = true
        self.keyboardType = .asciiCapable
    }
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(delete(_:)) || action == #selector(select(_:)) || action == #selector(selectAll(_:)) || action == #selector(makeTextWritingDirectionLeftToRight(_:)) || action == #selector(makeTextWritingDirectionRightToLeft(_:)) || action == #selector(toggleBoldface(_:)) || action == #selector(toggleItalics(_:)) || action == #selector(toggleUnderline(_:)) || action == #selector(increaseSize(_:)) || action == #selector(decreaseSize(_:)) {
            return true // return false copy paste no need
        }
        return true // return false copy paste no need
    }
    @IBInspectable var rightViewImage : UIImage? {
        get {
            return self.rightViewImage
        }
        set {
            if let image = newValue {
                
                let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height + 5, height: self.frame.height))
                contentView.backgroundColor = UIColor.clear
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height, height: contentView.frame.height))
                imageView.contentMode = .scaleAspectFit
                imageView.image = image
                contentView.addSubview(imageView)
                self.rightViewMode = .always
                self.rightView = contentView
            }
            else {
                self.rightView = nil
                self.rightViewMode = .never
            }
        }
    }
    @IBInspectable var leftViewImage : UIImage? {
        get {
            return self.leftViewImage
        }
        set {
            if let image = newValue {
                
                let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
                contentView.backgroundColor = UIColor.clear
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height, height: contentView.frame.height/2))
                imageView.contentMode = .scaleAspectFit
                imageView.center = CGPoint(x: imageView.center.x, y: contentView.center.y + 5)
                imageView.image = image
                contentView.addSubview(imageView)
                self.leftViewMode = .always
                self.leftView = contentView
            }
            else {
                self.leftViewMode = .never
                self.leftView = nil
            }
        }
    }
    @IBInspectable var needDropDownArrow : Bool {
        get {
            return self.needDropDownArrow
        }
        set {
            if newValue {
                let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
                contentView.backgroundColor = UIColor.clear
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
                imageView.contentMode = .scaleAspectFill
                imageView.center = contentView.center
                imageView.image = #imageLiteral(resourceName: "downArrow")
                contentView.isUserInteractionEnabled = false
                contentView.addSubview(imageView)
                self.rightViewMode = .always
                self.rightView = contentView
            }
            else {
                self.leftViewMode = .never
                self.leftView = nil
            }
        }
    }
    
    @IBInspectable var needDoneButton : Bool {
        get {
            return self.needDoneButton
        }
        set {
            
            if newValue {
                
                let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
                toolbar.barStyle = UIBarStyle.default
                toolbar.isTranslucent = true
                
                let flexibleSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
                let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(textFieldDoneButtonAction))
                
                toolbar.items = [flexibleSpaceRight,doneBtn]
                self.inputAccessoryView = toolbar
            }
            else {
                self.inputAccessoryView = nil
            }
        }
    }
    
    @objc func textFieldDoneButtonAction() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    func setRightViewIcon(icon: UIImage) {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height + 5, height: self.frame.height))
        contentView.backgroundColor = UIColor.clear
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height, height: contentView.frame.height))
        imageView.contentMode = .scaleAspectFit
        imageView.image = icon
        contentView.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = contentView
    }
    
    func setLeftViewIcon(icon: UIImage) {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height + 5, height: self.frame.height))
        contentView.backgroundColor = UIColor.clear
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.height, height: contentView.frame.height))
        imageView.contentMode = .scaleAspectFit
        imageView.image = icon
        contentView.addSubview(imageView)
        self.leftViewMode = .always
        self.leftView = contentView
    }
}
extension UIView {
    
    func setShadowWithCornerRadius() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
    }
    
    func drawShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3
        //      self.layer.borderColor = UIColor.gray.cgColor
        //      self.layer.borderWidth = 0.5
        //      self.clipsToBounds = true
    }
    
    func animShowHeight(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn],
                       animations: {
            self.center.y = self.bounds.height+25
            self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animationHideHeightInBottom(bottomHeight: Int){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveLinear],
                       animations: {
            self.center.y += self.bounds.height - CGFloat(bottomHeight)
            self.layoutIfNeeded()
            
        },  completion: {(_ completed: Bool) -> Void in
            //self.isHidden = true
        })
    }
    
    @objc func bottomanimationShow(){
        UIView.animate(withDuration: 3.0, delay: 0, options: [.curveEaseIn],
                       animations: {
            self.center.y -= self.bounds.height
            self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func bottomanimationHide(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveLinear],
                       animations: {
            self.center.y += self.bounds.height
            self.layoutIfNeeded()
            
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    
    func dropShadow(view: UIView, scale: Bool = true,shadowradius:CGFloat = 5,cornerRadius:CGFloat = 2.0) {
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowradius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
    }
    func setShadowForView(view: UIView) {
        layer.cornerRadius = 20.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.7
        
    }
    
    func setCorenerRadiusWithBorder(borderColor:UIColor){
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 0.3
    }
    func setCorenerRadius(){
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.size.height / 2
    }
    func setCorenerRadiusWith(radius:CGFloat){
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                self.scrollToRow(at: IndexPath(row: row - 1, section: section - 1), at: .bottom, animated: animated)
            }
        }
    }
}

extension AlertableView where Self: UIViewController {
    
    func displayAlert(with title: String, message: String, style: UIAlertController.Style, actions: [AlertButtons]?, completion: CompletionHandler?)  {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let actions = actions {
            for action in actions {
                let action = UIAlertAction(title: action.description, style: .default, handler: { (success) in
                    completion?(AlertButtons.Ok)
                })
                alertController.addAction(action)
            }
        } else {
            let action = UIAlertAction(title: AlertButtons.Ok.description, style: .default, handler: { (success) in
                completion?(AlertButtons.Ok)
            })
            alertController.addAction(action)
        }
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
}


extension String {
    func isValidPassword() -> Bool {
        //please check with JB/Raja on changing this.
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=).{8,}$" as String
        // let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=).{8,}$" as String
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with:self)
    }
    func isValidEmail() -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}" as String
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with:self)
    }
    func isValidMobileNumber() -> Bool
    {
        let phoneNumberRegex = "^[0-9,+ ]{6,20}$" as String
        
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        
        return phoneNumberTest.evaluate(with:self)
    }
    func trimWhiteSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    func toDate(withFormat format: String) -> Date? {
        return Date.CustomDateFormatter.dateFormatter(withFormat: format).date(from:  self)
    }
    func isTextEmpty() -> Bool {
        return self == ""
    }
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    var htmlToAttributedString: NSMutableAttributedString? {
        
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    //To get amount with comma
    func toFormattedAmount() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = Locale(identifier: "en_UK")
        
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(floatLiteral: Double(self)!))!
    }
}

//MARK: - Storyboard Designable Properties

extension UIButton {
    @IBInspectable var curvedButton : Bool {
        get {
            return self.cornerRadii <= 0 ? false : true
        }
        set {
            self.cornerRadii = self.frame.size.height/2 //25
        }
    }
    
    func BackgroundColor(){
        self.backgroundColor = App.AppTheme.Color
    }
    
    func BackgroundColorDisable(){
        self.backgroundColor = App.AppTheme.Color
    }
    
    func BorderEnable(){
        self.layer.borderColor = App.AppTheme.Color.cgColor
        self.layer.borderWidth = 1.0
        self.ButtonHighlightTextColor()
    }
    
    func BorderDisable(){
        self.layer.borderColor = App.AppTheme.Color.cgColor
        self.layer.borderWidth = 1.0
        self.ButtonRemoveHighlightTextColor()
    }
    
    func ButtonHighlightTextColor(){
        self.setTitleColor(App.AppTheme.Color, for: .normal)
    }
    
    func ButtonRemoveHighlightTextColor(){
        self.setTitleColor(App.AppTheme.Color, for: .normal)
    }
}

extension UIView {
    
    @IBInspectable var makeRounded : Bool {
        get {
            return self.cornerRadii <= 0 ? false : true
        }
        set {
            self.cornerRadii = self.frame.size.width/2
        }
    }
    
    @IBInspectable var cornerRadii : CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0 ? true : false
        }
    }
    
    @IBInspectable var borderColor : UIColor {
        get {
            guard let color = self.layer.borderColor else {return UIColor.black}
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var needCardShadow : Bool {
        get {
            return self.layer.shadowRadius > 0 ? true : false
        }
        set {
            
            if newValue {
                let shadowSize : CGFloat = 5.0
                let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                           y: -shadowSize / 2,
                                                           width: self.frame.size.width + shadowSize,
                                                           height: self.frame.size.height + shadowSize))
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.cornerRadius = 4.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                self.layer.shadowOpacity = 0.2
                self.layer.shadowPath = shadowPath.cgPath
            }
            else {
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
                self.layer.shadowPath = nil
            }
        }
    }
}

extension Date {
    
    struct CustomDateFormatter {
        
        static var currentTimeZone = TimeZone.current //Set default timeZone that you want
        
        static func dateFormatter(withFormat format: String) -> DateFormatter {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier:"en_US_POSIX") as Locale?
            formatter.timeZone = CustomDateFormatter.currentTimeZone
            formatter.dateFormat = format
            return formatter
        }
    }
    
    func toDateString(withFormat format: String) -> String {
        return CustomDateFormatter.dateFormatter(withFormat: format).string(from: self)
    }
}

extension UIViewController {
    //    func enableTextFieldFocus(forView : UIScrollView) {
    //
    //        currentScrollView = forView
    //
    //        let showNotification = NSNotification.init(name: .UIKeyboardWillShow, object: nil)
    //        let hideNotification = NSNotification.init(name: .UIKeyboardWillHide, object: nil)
    //
    //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: showNotification.name, object: nil)
    //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: hideNotification.name, object: nil)
    //    }
    //
    //    func disableTextFieldFocus() {
    //        let showNotification = NSNotification.init(name: .UIKeyboardWillShow, object: nil)
    //        let hideNotification = NSNotification.init(name: .UIKeyboardWillHide, object: nil)
    //
    //        NotificationCenter.default.removeObserver(self, name: showNotification.name, object: nil)
    //        NotificationCenter.default.removeObserver(self, name: hideNotification.name, object: nil)
    //    }
    
    //MARK: Keyboard Show/Hide methods
    
    @objc func keyboardWillShow(notification : Notification) {
        
        guard let userInfo = notification.userInfo else {return}
        
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 253
        
        if let scrollView = currentScrollView {
            
            let contentInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardHeight + 20, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification : Notification) {
        if let scrollView = currentScrollView {
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch _ {
            //print(myJSONError)
            return nil
        }
    }
    
}

extension Double {
    func toFormattedString() -> String {
        return String(format: "%.2f", self)
    }
}

extension Numeric {
    func toString() -> String {
        return String(describing: self)
    }
}

extension Notification.Name {
    static let infoButtonNotification = Notification.Name(rawValue: "infoButtonTap")
    static let paySelectionNotification = Notification.Name(rawValue: "PaySelection")
    static let addExternalBankNotification = Notification.Name(rawValue: "ExternalBank")
    
}

extension NSLocale {
    
    class func getCountryCode(countryName : String) -> String {
        /*
         NSArray *countryCodes = [NSLocale ISOCountryCodes];
         NSMutableArray *countries = [NSMutableArray arrayWithCapacity:[countryCodes count]];
         
         for (NSString *countryCode in countryCodes)
         {
         NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: countryCode forKey: NSLocaleCountryCode]];
         NSString *country = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"] displayNameForKey: NSLocaleIdentifier value: identifier];
         [countries addObject: country];
         }
         
         NSDictionary *codeForCountryDictionary = [[NSDictionary alloc] initWithObjects:countryCodes forKeys:countries];
         */
        
        //        var locales : String = ""
        //        for localeCode in NSLocale.isoCountryCodes {
        //            let resultCountryName = NSLocale.current.displayNameForKey(NSLocaleCountryCode, value: localeCode)
        //            if countryName.lowercaseString == resultCountryName.lowercaseString {
        //                return localeCode
        //            }
        //        }
        //        return locales
        
        let countryCodes = NSLocale.isoCountryCodes
        
        
        for countryCode in countryCodes {
            let name = Locale.current.localizedString(forRegionCode: countryCode)
            
            if name == countryName {
                return countryCode
            }
        }
        
        return ""
    }
}

extension Int {
    init(_ range: Range<Int> ) {
        let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
        let min = UInt32(range.lowerBound + delta)
        let max = UInt32(range.upperBound   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init?(colorCode: String) {
        var code = colorCode
        if code.contains("#") {
            code.remove(at: code.startIndex)
        }
        self.init(rgb: Int(code, radix: 16)!)
    }
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}


extension UIView{
    func shadow(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.25
    }
}

extension String {
    func md5() -> String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        data.withUnsafeBytes { buffer in
            _ = CC_MD5(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }
        
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension UIView{
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    class func loadNib() -> Self {
        return loadNib(self)
    }
}

extension UIButton{
    func roundCornerRadius(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
            self.center.y -= self.bounds.height
            self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear],
                       animations: {
            self.center.y += self.bounds.height
            self.layoutIfNeeded()
            
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    func fadeOut(duration: TimeInterval = 2.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}

extension UIButton{
    func cornerRadius(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    func selectedBorder(){
        self.layer.borderColor = App.AppTheme.Color.cgColor
        self.layer.borderWidth = 1
    }
    func deSelectedBorder(){
        self.layer.borderColor = UIColor.clear.cgColor
    }
    func selectedTextColor(){
        self.setTitleColor(App.AppTheme.Color, for: .normal)
    }
    func deSelectedTextColor(){
        
    }
    func btndropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
    }
}

extension UIView{
    func viewroundCornerRadius(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    
    func rightToLeftAnimation(){
        self.frame.origin.x = UIWindow().frame.size.width
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.frame.origin.x = 0
            self.isHidden = false
        }, completion: {(_ finished: Bool) -> Void in
        })
    }
    
    func leftToRightAnimation(){
        self.frame.origin.x = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.frame.origin.x -= UIWindow().frame.size.width
            self.isHidden = true
        }, completion: {(_ finished: Bool) -> Void in
        })
    }
}

extension UIView{
    func exceptTopLeftCorner(size: Int = 16){
        let buttonPath = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: [.topRight , .bottomLeft],
                                      cornerRadii: CGSize(width: size, height: size))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = buttonPath.cgPath
        layer.mask = maskLayer1
    }
    
    func dropShadow(shadowColour: CGColor = UIColor.darkGray.cgColor) {
        layer.shadowColor = shadowColour
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
    }
    func dropDarkShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
    }
    
    func carddropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.masksToBounds = false
        
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}

extension UIImageView{
    func addBlur(alpha: CGFloat = 0.95) {
        // create effect
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
    
    func imgdropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
    }
}

extension UIView {
    
    func addShadowWithBorder(radius: CGFloat, borderColor: UIColor = .clear) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true;
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 5;
        
        self.layer.contentsScale = UIScreen.main.scale
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero;
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.3;
        self.layer.masksToBounds = false;
        self.clipsToBounds = false;
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
extension UIView {
    func createDottedLine(width: CGFloat, color: CGColor,isVertical:Bool) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [4,2]
        let cgPath = CGMutablePath()
        var cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        if isVertical{
            cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: self.frame.height)]
        }
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
}
extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

extension UserDefaults {
    
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}

extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}

extension UIView {
    
    /// Flip view horizontally.
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UINavigationController {
    func popToHomeViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
}

class ViewPresenter {
    public static func replaceRootView(for viewController: UIViewController,
                                       duration: TimeInterval = 0.3,
                                       options: UIView.AnimationOptions = .transitionCrossDissolve,
                                       completion: ((Bool) -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        
        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: duration, options: options, animations: {
            window.rootViewController = viewController
        }, completion: completion)
    }
}

extension UIView{
    func bottomShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = UIColor.init(hexString: "#C0C0C0").cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension UIImage {
    var blackandwhite: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
           let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}

extension UITextField {
    func setLeftPadding(_ value:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPadding(_ value:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UILabel {
    
    func getHtmlToAttributed(htmlText: String){
        let encodedData = htmlText.data(using: String.Encoding.utf8)!
        var attributedString: NSAttributedString
        do {
            attributedString = try NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
            self.attributedText = attributedString
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("error")
        }
    }
}

//extension NSAttributedString{
//    func placeHolderTitle(content: String)-> NSAttributedString{
//        return NSAttributedString(
//            string: content,
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
//        )
//    }
//}
