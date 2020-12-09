//
//  AppDelegate.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let initViewController = InitViewController()
        window?.rootViewController = initViewController
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
        
        return true
    }



}

