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
        tabBar.barStyle = .black
        tabBar.backgroundColor = .black
        buildView()
    }
    
    func buildView() {
        let homeVC = configNavBar(HomeViewController())
        homeVC.tabBarItem.image = UIImage(systemName: Constants.Images.houseFill)
        homeVC.tabBarItem.title = Constants.Labels.start
        
        let inComingVC = configNavBar(InComingViewController())
        inComingVC.tabBarItem.image = UIImage(systemName: Constants.Images.rectangleFill)
        inComingVC.tabBarItem.title = Constants.Labels.releases
        
        viewControllers = [homeVC, inComingVC]
        guard let items = tabBar.items else {return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    func configNavBar(_ rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.isNavigationBarHidden = false
        nav.navigationBar.barStyle = .black
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.tintColor = .white
        nav.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                 target: self,
                                                                 action: nil)
        nav.interactivePopGestureRecognizer?.delegate = self
        return nav
    }
    
}

extension TabBarController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
