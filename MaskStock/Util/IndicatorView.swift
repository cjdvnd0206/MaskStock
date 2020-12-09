//
//  IndicatorView.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import UIKit

class IndicatorView : UIView {
    
    let indicatorView = UIActivityIndicatorView()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let shared : IndicatorView = {
        let instance = IndicatorView()
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        indicatorPrepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func indicatorPrepare() {
        self.backgroundColor = .clear
        self.frame = UIScreen.main.bounds
        indicatorView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicatorView.style = UIActivityIndicatorView.Style.medium
        indicatorView.center = self.center
        indicatorView.color = .gray
        self.addSubview(indicatorView)
    }
    
    func show() {
        appDelegate.window?.addSubview(indicatorView)
        indicatorView.startAnimating()
        indicatorView.bringSubviewToFront((appDelegate.window?.rootViewController?.view)!)
    }
    
    func hide() {
        self.removeFromSuperview()
        indicatorView.stopAnimating()
    }
    
}
