//
//  TabBarController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .black
        buildView()
    }
    
    func buildView() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.navigationBar.barStyle = UIBarStyle.black
        homeVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        homeVC.navigationBar.tintColor = .white
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        viewControllers = [homeVC]
        guard let items = tabBar.items else {return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
}
