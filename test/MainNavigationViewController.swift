//
//  MainNavigationViewController.swift
//  test
//
//  Created by Ricardo García on 8/9/19.
//  Copyright © 2019 Oclusion. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.pushViewController(mainViewController, animated: true)
    }

}
