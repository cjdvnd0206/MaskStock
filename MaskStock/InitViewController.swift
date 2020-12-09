//
//  InitViewController.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import UIKit

class InitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("App Loading Complete")
    }
    override func viewDidAppear(_ animated: Bool) {
        presentMainView()
    }
    
    private func presentMainView() {
        let loginViewController : MainViewController = MainViewController()
        let loginNavigationController : UINavigationController = UINavigationController(rootViewController: loginViewController)
        loginNavigationController.modalPresentationStyle = .fullScreen
        self.present(loginNavigationController, animated: true)
    }

}

