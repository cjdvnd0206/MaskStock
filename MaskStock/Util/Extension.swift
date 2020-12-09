//
//  Extension.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func openAppSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
}

fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

extension UIViewController {
    
    func alertHandler(_ message : String , actionButton : String? , handlerAction : ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: actionButton ?? "확인", style: UIAlertAction.Style.default, handler: handlerAction)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertMemoHandler(_ message : String , actionButton : String? , handlerAction : ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: "메모", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: actionButton ?? "확인", style: UIAlertAction.Style.default, handler: handlerAction)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertHandler(vc : UIViewController, _ msg : String, handlerAction : ((UIAlertAction) -> Void)? = nil) {
        let lampOnAlert = UIAlertController(title: "알림", message: msg, preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: handlerAction)
        lampOnAlert.addAction(onAction)
        vc.present(lampOnAlert, animated: true, completion: nil)
    }
    
    func showAlertCanelHandler(vc : UIViewController, _ msg : String, _ confirm : String = "확인", handlerAction : ((UIAlertAction) -> Void)? = nil, cancelHandlerAction : ((UIAlertAction) -> Void)? = nil) {
        let lampOnAlert = UIAlertController(title: "알림", message: msg, preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: confirm, style: UIAlertAction.Style.default, handler: handlerAction)
        let onCancel = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: cancelHandlerAction)
        lampOnAlert.addAction(onCancel)
        lampOnAlert.addAction(onAction)
        vc.present(lampOnAlert, animated: true, completion: nil)
    }
    
    func phoneCall(phoneNum: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNum)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func setNavigationBar(labelTitle: String) {
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .rgbColor(69, 79, 99)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .white

        let bottomView = UIView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!-5,
                                           width: (self.navigationController?.navigationBar.bounds.width)!,
                                           height: 20))
        bottomView.backgroundColor = .white
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 15
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.navigationController?.navigationBar.insertSubview(bottomView, at: 1)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 2, height: 44))
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .rgbColor(69, 79, 99)
        label.text = labelTitle
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        self.navigationController?.navigationBar.topItem?.titleView = label
    }
    
    
    
    func dismissController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func popupMenuViewRightToLeft(vc: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .reveal
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: false, completion: nil)
    }
    
    func dismissMenuViewLeftToRight() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .reveal
        transition.subtype = .fromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
    
    func addCancelHandlerAlert(viewController : UIViewController,_ title : String, _ message : String, handlerAction : ((UIAlertAction) -> Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction(title: "설정", style: UIAlertAction.Style.default, handler: handlerAction)
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    func delDateHypen(date: String) -> String {
        return date.replacingOccurrences(of: "-", with: "")
    }
}

extension String {
    
    func delDateSlice() -> String {
        return self.replacingOccurrences(of: "-", with: "")
    }
    
    func addFeeFormat() -> String {
        if self.isEmpty {
            return "0"
        }
        else {
            let value: NSNumber = NSNumber(integerLiteral: Int(self)!)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            let resultValue = formatter.string(from: value)
            return resultValue!
        }
    }
    
    func delDateSecondFormat() -> String {
        if self.isEmpty {
            return ""
        }
        else {
            let firstIndex = self.index(self.startIndex, offsetBy: 0)
            let lastIndex = self.index(self.startIndex, offsetBy: 10)
            return String(self[firstIndex..<lastIndex])
        }
    }
    
    func addHypenFormat() -> String {
        if self.isEmpty {
            return ""
        }
        else {
            var string = self
            var index1: String.Index?
            var index2: String.Index?
            var index3: String.Index?
            var index4: String.Index?
            
            switch(string.count) {
            case 8: //19700101
                index1 = string.index(string.startIndex, offsetBy: 4)
                index2 = string.index(string.startIndex, offsetBy: 7)
                break
            case 9: //021231234
                index1 = string.index(string.startIndex, offsetBy: 2)
                index2 = string.index(string.startIndex, offsetBy: 7)
                break
            case 10: // 0212341234, 0311231234
                if string.contains("02") {
                    index1 = string.index(string.startIndex, offsetBy: 2)
                    index2 = string.index(string.startIndex, offsetBy: 7)
                }
                else {
                    index1 = string.index(string.startIndex, offsetBy: 3)
                    index2 = string.index(string.startIndex, offsetBy: 7)
                }
                break
            case 11: // 01012341234
                index1 = string.index(string.startIndex, offsetBy: 3)
                index2 = string.index(string.startIndex, offsetBy: 8)
                break
            case 13 : // 010-1234-1234
                return self
            case 19:
                string.append(" ")
                index1 = string.index(string.startIndex, offsetBy: 4)
                index2 = string.index(string.startIndex, offsetBy: 7)
                index3 = string.index(string.startIndex, offsetBy: 17)
                index4 = string.index(string.startIndex, offsetBy: 20)
                break
            default: // 번호가 아예 없을경우
                index1 = string.index(string.startIndex, offsetBy: 0)
                index2 = string.index(string.startIndex, offsetBy: 0)
                break
            }
            string.insert("-", at: index1!)
            string.insert("-", at: index2!)
            if string.count == 22 {
                string.insert("-", at: index3!)
                string.insert("-", at: index4!)
            }
            
            return string
        }
    }
}

extension UIAlertController {
    
    func networkStateShowAlert(vc : UIViewController, handlerAction : ((UIAlertAction) -> Void)? = nil) {
        let lampOnAlert = UIAlertController(title: "알림", message: "네트워크 연결 상태를 확인한 후, 다시 시도해 주세요", preferredStyle: UIAlertController.Style.alert)
        let onAction = UIAlertAction(title: "재시도", style: UIAlertAction.Style.default, handler: handlerAction)
        lampOnAlert.addAction(onAction)
        vc.present(lampOnAlert, animated: true, completion: nil)
    }
}

extension UIColor {
    
    static func rgbColor(_ red : CGFloat , _ green : CGFloat, _ blue : CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        print("Hex : \(hex)")
        let a, r, g, b: UInt32
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
    
    func colorCustom(red: CGFloat , green: CGFloat, blue: CGFloat) -> UIColor{
        let color = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        return color
    }
    
    static var pmsBackgroundColor = UIColor.rgbColor(238, 241, 247)
    static var pmsShadowColor = UIColor.rgbColor(123, 123, 123)
}

extension UINavigationController {
    
    func defaultNavigationController() {
        self.navigationBar.isHidden = false
        if self.navigationBar.topItem?.leftBarButtonItems?.count ?? 0 > 0 {
            self.navigationBar.topItem?.leftBarButtonItems?.removeFirst()
        }
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationBar.tintColor = .black
    }
    
    func navigationbarCustom(_ navi : UINavigationController) {
        navi.navigationBar.isHidden = false
        navi.navigationBar.isTranslucent = true
        if navi.navigationBar.topItem?.leftBarButtonItems?.count == 1 {
            //navi.navigationBar.topItem?.leftBarButtonItems?.removeFirst()
        }
        navi.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let imageColor = UIImage.imageFromColor(color: UIColor.init(displayP3Red: 1, green: 1, blue: 1, alpha: 0.7))
        navi.navigationBar.setBackgroundImage(imageColor, for: .default)
        navi.navigationBar.tintColor = UIColor.black
    }
}

extension UIImage {
    
    func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size , view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    /// Creates a circular outline image.
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func imageFromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        // create a 1 by 1 pixel context
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIImageView {
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIActivityIndicatorView {
    
    func startAnimating(_ view : UIView){
        self.center = view.center
        self.hidesWhenStopped = true
        self.style = .medium
        view.addSubview(self)
        self.startAnimating()
    }
    
    func stopAnimating(_ view : UIView){
        self.stopAnimating()
    }
}

extension NSObject {
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension Date {
    
    func shortYear() -> String{
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy"
        let date = fomatter.string(from: Date())
        return date
    }
}

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let confirm = UIBarButtonItem(title: "확인", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, confirm], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}

extension CALayer {
    
    func applyShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, radius: CGFloat) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = radius
    }
}

extension UITabBar {
    
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = .white
    }
}
