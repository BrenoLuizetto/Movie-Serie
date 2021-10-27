//
//  BaseViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 27/10/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        self.statusBarStyle = .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.barTintColor = UIColor(red: 0,
                                                        green: 0,
                                                        blue: 0,
                                                        alpha: 0.5)
    }
    
}
